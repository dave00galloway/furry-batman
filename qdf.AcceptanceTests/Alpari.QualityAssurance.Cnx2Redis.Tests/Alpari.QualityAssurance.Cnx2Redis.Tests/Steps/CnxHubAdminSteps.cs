using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Globalization;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminSteps : CnxHubAdminStepBase
    {
        public new static readonly string FullName = typeof (CnxHubAdminSteps).FullName;

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

        [Given(@"I have a list of logins from the trade activity report")]
        public void GivenIHaveAListOfLoginsFromTheTradeActivityReport()
        {
           // CnxHubTradeActivityImporter.LoadData("queryName",new ExportParameters());
            throw new NotImplementedException();
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

        [When(@"I load cnx trade activities with the side reversed from ""(.*)"" for the included logins")]
        public void WhenILoadCnxTradeActivitiesWithTheSideReversedFromForTheIncludedLogins(string filenamePath)
        {
            ScenarioContext.Current["ExampleIdentifier"] = filenamePath;
            CnxHubTradeActivityImporter.IncludedLoginsList = IncludedLoginsList;
            WhenILoadCnxTradeActivitiesFrom(filenamePath);
            CnxHubTradeActivityImporter.ReverseDealSide();
        }

        [When(@"I load cnx trade activities for ""(.*)"" for the included logins")]
        public void WhenILoadCnxTradeActivitiesForForTheIncludedLogins(string reportDate)
        {
            ScenarioContext.Current["ExampleIdentifier"] = reportDate;
            CnxHubTradeActivityImporter.IncludedLoginsList = IncludedLoginsList;
            CnxHubTradeActivityImporter.LoadData(SetupImportParametersForTradeActivityReport(reportDate));
            CnxHubTradeActivityImporter.ReverseDealSide();
        }

        [When(@"I load cnx trade activities from '(.*)' to '(.*)' for the included logins")]
        public void WhenILoadCnxTradeActivitiesFromToForTheIncludedLogins(DateTime fromDate, DateTime toDate)
        {
            var reportMonth = fromDate.Month;
            var reportYear = fromDate.Year;
            var append = false;
            var reportDate = new DateTime(reportYear,reportMonth,fromDate.Day);
            while (reportDate <= toDate)
            {
                CnxHubTradeActivityImporter.LoadData(SetupImportParametersForTradeActivityReport(reportDate.ToString(CultureInfo.InvariantCulture)), append, String.Format("Alpari UK_TradeActivity_{0}_{1}.csv", reportYear,reportMonth));
                reportDate = reportDate.AddDays(1);
                append = reportDate.Month == reportMonth;
                reportMonth = reportDate.Month;
            }
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
            DealSearchCriteria.ConvertedEndTime = CnxHubTradeActivityImporter.LatestTradeActivityDateTime +
                                                  new TimeSpan(0, 0, 1) - new TimeSpan(1);
        }

        [When(@"I filter the qdf deals by the included logins")]
        public void WhenIFilterTheQdfDealsByTheIncludedLogins()
        {
            QDF.UIClient.Tests.Steps.StepCentral.RedisConnectionHelper.RetrievedDeals =
                FilterRetrievedDealsByIncludedLoginsList();
            FilterByKiwiRolloverTimes();
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
            DataTableComparison diffs = CompareCnxHubAdminDealsWithQdfCnxDeals(table);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [Then(@"the cnx hub trade deals should match the qdf deal data exactly:-")]
        public void ThenTheCnxHubTradeDealsShouldMatchTheQdfDealDataExactly_(ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];
            exportParameters.Path = ScenarioOutputDirectory;
            diffs.CheckForDifferences(exportParameters, true).Should().BeNullOrWhiteSpace();
        }

        [Then(@"the cnx hub trade deals compared with the qdf deal data should contain (.*) ""(.*)"":-")]
        public void ThenTheCnxHubTradeDealsComparedWithTheQdfDealDataShouldContain_(int diffCount, string diffType, ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            //diffs.CheckForDifferences(exportParameters);
            diffs.QueryDifferences(diffCount, diffType, exportParameters);
        }

    }
}