using System;
using System.Collections.Generic;
using System.Configuration;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminWebClientSteps : StepCentral
    {
        public new static readonly string FullName = typeof (CnxHubAdminWebClientSteps).FullName;

        public CnxHubAdminWebClientSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            CurrenexHubAdminWebClient currenexHubAdminWebClient)
            : base(cnxTradeTableDataContext)
        {
            CurrenexHubAdminWebClient = currenexHubAdminWebClient;
        }

        public CurrenexHubAdminWebClient CurrenexHubAdminWebClient { get; private set; }
        public IList<string> CleanedLines { get; private set; }

        [Given(@"I have connected to currenex hub admin")]
        public void GivenIHaveConnectedToCurrenexHubAdmin()
        {
            //CurrenexHubAdminWebClient.Login("auk_dgalloway", "auk12345");
            CurrenexHubAdminWebClient.Login(
                ConfigurationManager.AppSettings[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_USER_NAME],
                ConfigurationManager.AppSettings[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_PASSWORD]);

            // Download some secure resource
            string result =
                CurrenexHubAdminWebClient.DownloadString("https://pret.currenex.com/webadmin/report/list.action");
            result.Should().NotBeNullOrWhiteSpace();
        }

        [When(@"I request the trade activity report as csv")]
        public void WhenIRequestTheTradeActivityReportAsCsv()
        {
            //CleanedLines = CurrenexHubAdminWebClient.DownloadCleanedTradeActivityReportAndSaveToFile(
            //    @"C:\temp\test.csv", "08/04/2014", "08/01/2014", "08/01/2014");
            CleanedLines = CurrenexHubAdminWebClient.DownloadCleanedTradeActivityReportAndSaveToFile(
                @"C:\temp\test.csv", DateTime.Today.ToString("MM-dd-yyyy"), "08/01/2014", "08/01/2014");
        }

        [Then(@"the cleaned trade activity report contains (.*) records")]
        public void ThenTheCleanedTradeActivityReportContainsRecords(int expectedRecords)
        {
            CleanedLines.Should().HaveCount(expectedRecords);
        }

        public void LogOut()
        {
            string result = CurrenexHubAdminWebClient.LogOut();
            result.Should().Contain("Logged out successfully");
        }
    }
}