using System.Configuration;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminStepBase : StepCentral
    {
        private const string NZD_ROLLOVER_NAME = "NZDRollover";
        private const string OTHER_ROLLOVER_NAME = "OtherRollover";
        public new static readonly string FullName = typeof(CnxHubAdminStepBase).FullName; 
        public CnxHubAdminStepBase(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter) : base(cnxTradeTableDataContext)
        {
            CnxHubTradeActivityImporter = cnxHubTradeActivityImporter;
        }

        protected static IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        protected static ICnxHubTradeActivityImporter CnxHubTradeActivityImporter { get; private set; }
        protected DealSearchCriteria DealSearchCriteria { get; set; }

        [StepArgumentTransformation]
        public static IEnumerable<IncludedLogins> IncludedLoginsTransform(Table table)
        {
            return table.CreateSet<IncludedLogins>();
        }

        protected static List<Deal> FilterRetrievedDealsByIncludedLoginsList()
        {
            if (IncludedLoginsList == null)
            {
                return QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals;
            }
            return QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.Where(
                deal =>
                    IncludedLoginsList.Any(
                        l =>
                            String.Equals(l.Login.Trim(), deal.ClientId.Trim(),
                                StringComparison.InvariantCultureIgnoreCase))).ToList();
        }

        protected DataTableComparison CompareCnxHubAdminDealsWithQdfCnxDeals(Table table)
        {
            var ignoredFieldsQuery = table.IgnoredFieldsQuery();
            var cnxHubDealsAsTestableDeals =
                CnxHubTradeActivityImporter.CnxTradeActivityList.MapCnxTradeActivityToTestableDeals();
            var cnxDealsAsTestableDealDataTable =
                new TestableDealDataTable().ConvertIEnumerableToDataTable(cnxHubDealsAsTestableDeals,
                    "cnx-hub",
                    new[] { "DealId" });
            TestableDealDataTable qdfDealsAsTestableDealDataTable;

            switch (DealSearchCriteria.DealSource)
            {
                case "cnxstp-pret-deals-all":
                case "cnx-deals":
                    qdfDealsAsTestableDealDataTable = new TestableDealDataTable().ConvertIEnumerableToDataTable(
                        QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTestableDeals(),
                        DealSearchCriteria.DealSource,
                        new[] { "DealId" });
                    break;
                case "cnx-fix-deals":
                    qdfDealsAsTestableDealDataTable = new TestableDealDataTable().ConvertIEnumerableToDataTable(
                        QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTestableDeals(),
                        DealSearchCriteria.DealSource,
                        new[] { "DealId", "Comment" });
                    break;
                default:
                    throw new ArgumentException(String.Format("Deal Source {0} is not supported", DealSearchCriteria.DealSource));
            }

            var diffs = cnxDealsAsTestableDealDataTable.Compare(qdfDealsAsTestableDealDataTable, ignoredFieldsQuery, null, false,
                true);
            return diffs;
        }

        /// <summary>
        /// Probably loads of bugs in here as we're coding around a defect in QDF, and uncertain reporting conventions on Cnx
        /// Hopefully not too many exceptions will fall out, but not every case has been tested here!
        /// Bugs in the provided data from Cnx mean some Kiwi deals that shopuld have been rolled onto the next day are included, 
        /// and will appear as missing and will need to be manually checked. It's not too many though, and not worth filtering the cnxhub data
        /// If the daily report was incorrect, then the cnx hub data would be unusable
        /// </summary>
        protected void FilterByKiwiRolloverTimes()
        {
            //get rollovertimes
            int kiwiRolloverHour = Convert.ToInt16(ConfigurationManager.AppSettings[NZD_ROLLOVER_NAME]); //19
            int otherRolloverHour = Convert.ToInt16(ConfigurationManager.AppSettings[OTHER_ROLLOVER_NAME]); // 21;

            //get deals
            var deals = QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals;
            //determine start and end days
            var firstOrDefault = deals.FirstOrDefault();
            var startDate = firstOrDefault != null ? firstOrDefault.TimeStamp.Date : new DateTime();
            var lastOrDefault = deals.LastOrDefault();
            var lastDate = lastOrDefault != null ? lastOrDefault.TimeStamp.Date : new DateTime();
            var kiwiRolloverDeals = new List<Deal>();
            var nonKiwiRolloverDeals = new List<Deal>();
            if (firstOrDefault == null || lastOrDefault == null) return;
            
            var firstRollOverStart = new DateTime(firstOrDefault.TimeStamp.Year, firstOrDefault.TimeStamp.Month, firstOrDefault.TimeStamp.Day, kiwiRolloverHour, 0, 0);
            
            var firstRollOverEnd = new DateTime(firstOrDefault.TimeStamp.Year, firstOrDefault.TimeStamp.Month,
                firstOrDefault.TimeStamp.Day, otherRolloverHour, 0, 0);
            var lastRollOverStart = new DateTime(lastOrDefault.TimeStamp.Year, lastOrDefault.TimeStamp.Month, lastOrDefault.TimeStamp.Day, kiwiRolloverHour, 0, 0);
            var lastRollOverEnd = new DateTime(lastOrDefault.TimeStamp.Year, lastOrDefault.TimeStamp.Month,
                lastOrDefault.TimeStamp.Day, otherRolloverHour, 0, 0);
            if (startDate != lastDate || (startDate == lastDate & lastOrDefault.TimeStamp.TimeOfDay >= firstRollOverEnd.TimeOfDay))
            {
                /* reporting spans midnight, or finishes at midnight on d0 
                 * (determined by last deal having a time after 21:00)
                 * this particular step could be a potential source of bugs if there aren't many deals on a given reporting day
                 */
                //filter non kiwi deals from start of reporting period
                kiwiRolloverDeals =
                    deals.Where(
                        x =>
                            (x.TimeStamp >= firstRollOverStart && x.TimeStamp <= firstRollOverEnd) &&
                             (x.Instrument.Contains("NZD"))).ToList();
            }

            if (startDate != lastDate || (startDate == lastDate & firstOrDefault.TimeStamp.TimeOfDay <= firstRollOverStart.TimeOfDay)) 
                /* reporting spans midnight, or starts at midnight on d0 (determined by the first deal having a time before 19:00)
                 * less likely than previous step, but also a potential source of bugs on slow trading days
                 */
            {
                //filter Kiwi deals from end of reporting period
                nonKiwiRolloverDeals =
                    deals.Where(
                        x =>
                            (x.TimeStamp >= lastRollOverStart && x.TimeStamp <= lastRollOverEnd) &&
                             (!x.Instrument.Contains("NZD"))).ToList();
            }

            //get all deals which aren't in any part of the rollover
            List<Deal> regularDeals;
            if (startDate == lastDate)
            {
                if (lastOrDefault.TimeStamp.TimeOfDay >= firstRollOverEnd.TimeOfDay)
                {
                    //we already have kiwi deals from rollover, need all other deals up to midnight
                    regularDeals = deals.Where(x => x.TimeStamp.TimeOfDay >= firstRollOverEnd.TimeOfDay).ToList();
                }
                else
                {
                    //if started at midnight then we have non kiwi deals from the rollover period already, we need all deals before rollover
                    regularDeals = deals.Where(x => x.TimeStamp.TimeOfDay <= firstRollOverStart.TimeOfDay).ToList();
                }
            }
            else
            {
                regularDeals = deals.Where(x => x.TimeStamp >= firstRollOverEnd && x.TimeStamp <= lastRollOverStart).ToList();
            }

            // finally, get all deal ids from the cnx hub admin report and use these to query the retrieved deals from Redis to get any outliers
            // could be a huge performance hit but will avoid any more faffing trying to match up the rollover rules
            // perfromance hit is around 8+ times for a month's worth of data
            var dealsWithMatchingIdsInCnxHubAdminReport =
                deals.Where(
                    x => 
                        (x.TimeStamp <= firstRollOverEnd || x.TimeStamp >= lastRollOverStart) && // added time checks to help reduce performance hit
                        CnxHubTradeActivityImporter.CnxTradeActivityList.Any(
                            a =>
                                String.Equals(a.TradeId.Trim(), x.DealId.Trim(),
                                    StringComparison.InvariantCultureIgnoreCase))).ToList();

            deals = dealsWithMatchingIdsInCnxHubAdminReport.Concat(regularDeals.Concat(kiwiRolloverDeals.Concat(nonKiwiRolloverDeals))).Distinct().ToList();

            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals = deals;
        }
    }
}