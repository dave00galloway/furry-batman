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
            var ignoredFieldsQuery = IgnoredFieldsQuery(table);
            var cnxHubDealsAsTestableDeals =
                CnxHubTradeActivityImporter.CnxTradeActivityList.MapCnxTradeActivityToTestableDeals();
            var cnxDealsAsTestableDealDataTable =
                new TestableDealDataTable().ConvertIEnumerableToDataTable(cnxHubDealsAsTestableDeals,
                    "cnx-hub",
                    new[] { "DealId" });
            TestableDealDataTable qdfDealsAsTestableDealDataTable;

            switch (DealSearchCriteria.DealSource)
            {
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
    }
}