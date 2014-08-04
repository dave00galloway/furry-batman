using System.Collections.Specialized;
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

        public CnxHubAdminWebClientSteps(CnxTradeTableDataContext cnxTradeTableDataContext)
            : base(cnxTradeTableDataContext)
        {
        }

        public CurrenexHubAdminWebClient CurrenexHubAdminWebClient { get; set; }

        [Given(@"I have connected to currenex hub admin")]
        public void GivenIHaveConnectedToCurrenexHubAdmin()
        {
            // create a new instance of WebClient
            CurrenexHubAdminWebClient = new CurrenexHubAdminWebClient("Certificates\\pret.pfx", "password");

            CurrenexHubAdminWebClient.Login("auk_dgalloway", "auk12345", "https://pret.currenex.com");

            // Download some secure resource
            string result = CurrenexHubAdminWebClient.DownloadString("https://pret.currenex.com/webadmin/report/list.action");
            result.Should().NotBeNullOrWhiteSpace();
        }



        [When(@"I request the trade activity report as csv")]
        public void WhenIRequestTheTradeActivityReportAsCsv()
        {
            var responseString = CurrenexHubAdminWebClient.DownloadTradeActivityReportAsCsv("08/04/2014", "08/01/2014", "08/01/2014", "https://pret.currenex.com");
        }


        public void LogOut()
        {
            string result;
            // set the user agent to chrome
            var headers = new NameValueCollection
            {
                {
                    "user-agent",
                    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
                },
                {
                    "Origin",
                    "https://pret.currenex.com"
                },
                {
                    "Accept-Encoding",
                    "gzip,deflate,sdch"
                },
                {
                    "Host",
                    "pret.currenex.com"
                },
                {
                    "Accept-Language",
                    "en-US,en;q=0.8"
                },
                {
                    "Accept",
                    "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                },
                {
                    "Referer",
                    "https://pret.currenex.com/webadmin/index.action"
                }
            };
            CurrenexHubAdminWebClient.Headers.Clear();
            CurrenexHubAdminWebClient.Headers.Add(headers);

            result = CurrenexHubAdminWebClient.DownloadString("https://pret.currenex.com/webadmin/logout.action");
            result.Should().Contain("Logged out successfully");
        }
    }
}