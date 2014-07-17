using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
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
            DealSearchCriteria criteria = QdfDataRetrievalSteps.DealSearchCriteria;
            criteria.ConvertedStartTime = CnxHubTradeActivityImporter.EarliestTradeActivityDateTime;
            //need to add 1 tick to the end time as the precision of the cnx Hub times stops at seconds
            //actually this doesn't quite work. Let's try adding a second then subtracting 1 tick.
            criteria.ConvertedEndTime = CnxHubTradeActivityImporter.LatestTradeActivityDateTime + new TimeSpan(0,0,1) - new TimeSpan((long)1);
        }

        [When(@"I filter the qdf deals by the included logins")]
        public void WhenIFilterTheQdfDealsByTheIncludedLogins()
        {
            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals =
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.Where(
                    deal =>
                        IncludedLoginsList.Any(
                            l =>
                                String.Equals(l.Login.Trim(), deal.ClientId.Trim(),
                                    StringComparison.InvariantCultureIgnoreCase))).ToList();
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
            var ignoredFieldsQuery = IgnoredFieldsQuery(table);
            var cnxHubDealsAsTestableDeals =
                CnxHubTradeActivityImporter.CnxTradeActivityList.MapCnxTradeActivityToTestableDeals();
            var cnxDealsAsTestableDealDataTable =
                new TestableDealDataTable().ConvertIEnumerableToDataTable(cnxHubDealsAsTestableDeals,
                    "cnx-hub",
                    new[] { "DealId" });
            var qdfDealsAsTestableDealDataTable = new TestableDealDataTable().ConvertIEnumerableToDataTable(
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTestableDeals(), "cnx-deals",
                new[] { "DealId", "Comment" });
                //new[] { "DealId" });//TODO:- create a seperate step definition which enables/disables the different primary keys. It's not currently affecting except for slowing them down slightly when the faster comparison method could be used
            var diffs = cnxDealsAsTestableDealDataTable.Compare(qdfDealsAsTestableDealDataTable, ignoredFieldsQuery, null, false, true);
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