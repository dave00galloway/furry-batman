using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminSteps : CnxHubAdminStepBase
    {
        public new static readonly string FullName = typeof(CnxHubAdminSteps).FullName; 
        public CnxHubAdminSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter)
            : base(cnxTradeTableDataContext, cnxHubTradeActivityImporter)
        {
        }

        [Given(@"I have this list of takers to load from cnx hub")]
        public void GivenIHaveThisListOfTakersToLoadFromCnxHub(IEnumerable<IncludedLogins> includedLogins)
        {
            IncludedLoginsList = includedLogins;
        }

        [When(@"I load cnx trade activities from ""(.*)""")]
        public void WhenILoadCnxTradeActivitiesFrom(string filenamePath)
        {
            CnxHubTradeActivityImporter.LoadData(new ExportParameters {FileName = filenamePath});
        }

        [When(@"I load cnx trade activities from ""(.*)"" for the included logins")]
        public void WhenILoadCnxTradeActivitiesFromForTheIncludedLogins(string filenamePath)
        {
            CnxHubTradeActivityImporter.IncludedLoginsList = IncludedLoginsList;
            WhenILoadCnxTradeActivitiesFrom(filenamePath);
        }

        [When(@"I load cnx trade activities from ""(.*)"" and reverse the deal side")]
        public void WhenILoadCnxTradeActivitiesFromAndReverseTheDealSide(string filenamePath)
        {
            WhenILoadCnxTradeActivitiesFromForTheIncludedLogins(filenamePath);
            CnxHubTradeActivityImporter.ReverseDealSide();
        }

        [When(@"I update the qdf deal criteria with start and end times")]
        public void WhenIUpdateTheQdfDealCriteriaWithStartAndEndTimes()
        {
            DealSearchCriteria = QdfDataRetrievalSteps.DealSearchCriteria;
            DealSearchCriteria.ConvertedStartTime = CnxHubTradeActivityImporter.EarliestTradeActivityDateTime;
            //need to add 1 tick to the end time as the precision of the cnx Hub times stops at seconds
            //actually this doesn't quite work. Let's try adding a second then subtracting 1 tick.
            DealSearchCriteria.ConvertedEndTime = CnxHubTradeActivityImporter.LatestTradeActivityDateTime + new TimeSpan(0,0,1) - new TimeSpan((long)1);
        }

        [When(@"I filter the qdf deals by the included logins")]
        public void WhenIFilterTheQdfDealsByTheIncludedLogins()
        {
            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals =
                FilterRetrievedDealsByIncludedLoginsList();
            FilterByKiwiRolloverTimes();
        }

        private void FilterByKiwiRolloverTimes()
        {
            //get deals
            var deals = QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals;
            //determine start and end days
            var firstOrDefault = deals.FirstOrDefault();
            int startDay;
            startDay = firstOrDefault != null ? firstOrDefault.TimeStamp.Day : 0;
            var lastOrDefault = deals.LastOrDefault();
            int lastDay;
            lastDay = lastOrDefault != null ? lastOrDefault.TimeStamp.Day : 0;
            var kiwiRolloverDeals = new List<Deal>();
            var nonKiwiRolloverDeals = new List<Deal>();
            if (firstOrDefault == null || lastOrDefault == null) return;
            var firstRollOverStart = new DateTime(firstOrDefault.TimeStamp.Year,firstOrDefault.TimeStamp.Month, firstOrDefault.TimeStamp.Day,19,0,0);
            var firstRollOverEnd = new DateTime(firstOrDefault.TimeStamp.Year, firstOrDefault.TimeStamp.Month,
                firstOrDefault.TimeStamp.Day, 21, 0, 0);// - new TimeSpan((long)1);
            var lastRollOverStart = new DateTime(lastOrDefault.TimeStamp.Year, lastOrDefault.TimeStamp.Month, lastOrDefault.TimeStamp.Day, 19, 0, 0);
            var lastRollOverEnd = new DateTime(lastOrDefault.TimeStamp.Year, lastOrDefault.TimeStamp.Month,
                lastOrDefault.TimeStamp.Day, 21, 0, 0);// - new TimeSpan((long)1);
            if (startDay != lastDay || firstOrDefault.TimeStamp.TimeOfDay != new TimeSpan(0,0,0)) // reporting spans midnight, or finishes at midnight on d0 (determined by start date not starting at midnight)
            {
                //filter non kiwi deals from start of reporting period
                kiwiRolloverDeals =
                    deals.Where(
                        x =>
                            (x.TimeStamp >= firstRollOverStart && x.TimeStamp <= firstRollOverEnd) &&
                             (x.Instrument.Contains("NZD"))).ToList();
            }

            //filter Kiwi deals from end of reporting period
            if (startDay != lastDay || firstOrDefault.TimeStamp.TimeOfDay == new TimeSpan(0, 0, 0)) // reporting spans midnight, or starts at midnight on d0
            {
                //filter non kiwi deals from start of reporting period
                nonKiwiRolloverDeals =
                    deals.Where(
                        x =>
                            (x.TimeStamp >= lastRollOverStart && x.TimeStamp <= lastRollOverEnd) &&
                             (!x.Instrument.Contains("NZD"))).ToList();
            }

            //get all deals which aren't in any part of the rollover
            var regularDeals = deals.Where(x => x.TimeStamp >= firstRollOverEnd && x.TimeStamp <= lastRollOverStart).ToList();

            deals = regularDeals.Concat(kiwiRolloverDeals.Concat(nonKiwiRolloverDeals)).Distinct().ToList();

            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals = deals;
        }

        [When(@"I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins")]
        public void WhenIRetrieveTheQdfDealDataFilteredByCnxHubStartAndEndTimesAndByIncludedLogins()
        {
            WhenIUpdateTheQdfDealCriteriaWithStartAndEndTimes();
            QdfDataRetrievalSteps.WhenIRetrieveTheQdfDealData();
            WhenIFilterTheQdfDealsByTheIncludedLogins();
        }

        [When(@"I compare the cnx hub trade deals with the qdf deal data excluding these fields:")]
        public void WhenICompareTheCnxHubTradeDealsWithTheQdfDealDataExcludingTheseFields(Table table)
        {
            var diffs = CompareCnxHubAdminDealsWithQdfCnxDeals(table);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [Then(@"the cnx hub trade deals should match the qdf deal data exactly:-")]
        public void ThenTheCnxHubTradeDealsShouldMatchTheQdfDealDataExactly_(ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            exportParameters.Path = ScenarioOutputDirectory;
            diffs.CheckForDifferences(exportParameters, true).Should().BeNullOrWhiteSpace();
        }
    }
}