using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminWebClientSteps : StepCentral
    {
        public new static readonly string FullName = typeof(CnxHubAdminWebClientSteps).FullName;

        public CnxHubAdminWebClientSteps(CnxTradeTableDataContext cnxTradeTableDataContext) : base(cnxTradeTableDataContext)
        {
        }

        public WebClientEx WebClientEx { get; set; }

        [Given(@"I have connected to currenex hub admin")]
        public void GivenIHaveConnectedToCurrenexHubAdmin()
        {
            string result;
            // create a new instance of WebClient
            WebClientEx = new WebClientEx();

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
                    "Content-Type",
                    "application/x-www-form-urlencoded"
                },
                {
                    "Accept",
                    "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                },
                {
                    "Cache-Control",
                    "max-age=0"
                },
                {
                    "Referer",
                    "https://pret.currenex.com/webadmin/index.action"
                }
                //{
                //    "Connection",
                //    "keep-alive"
                //},
            };
            WebClientEx.Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"e2ee", ""},
                {"username", "auk_dgalloway"},
                {"password", "auk12345"},
                {"loginsource", ""}
            };

            // Authenticate
            WebClientEx.UploadValues("https://pret.currenex.com/webadmin/loginAction.action", values);

            // Download some secure resource
            result = WebClientEx.DownloadString("https://pret.currenex.com/webadmin/report/list.action");
            result.Should().NotBeNullOrWhiteSpace();
        }

        [When(@"I request the trade activity report")]
        public void WhenIRequestTheTradeActivityReport()
        {
            //string result;
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
                    "Content-Type",
                    "application/x-www-form-urlencoded"
                },
                {
                    "Accept",
                    "*/*"
                },
                {
                    "Cache-Control",
                    "max-age=0"
                },
                {
                    "Referer",
                    "https://pret.currenex.com/webadmin/index.action"
                },
                {
                    "X-Requested-With",
                    "XMLHttpRequest"
                },
            };

            WebClientEx.Headers.Clear();
            WebClientEx.Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"currentDate", "08/04/2014"},
                {"pageIndex", "0"},
                {"view", "HTML"},
                {"fromDateStr", "08/01/2014"},
                {"toDateStr", "08/01/2014"},
                {"selectedAccountId", ""},
                {"selectReport", "Trade Report"}
                };

            // Post Values
            var response = WebClientEx.UploadValues("https://pret.currenex.com/webadmin/report/viewTradeReport.action", values); //works,, but what to do with a byte array?
            var responseString = Encoding.Default.GetString(response); // works, but there's an error message in the response

            // Download some secure resource
            //result = WebClientEx.DownloadString("https://pret.currenex.com/webadmin/report/viewTradeReport.action");
            //result.Should().NotBeNullOrWhiteSpace();
        }

        [When(@"I request the trade activity report as csv")]
        public void WhenIRequestTheTradeActivityReportAsCsv()
        {
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
                    "Content-Type",
                    "application/x-www-form-urlencoded"
                },
                {
                    "Accept",
                    "*/*"
                },
                //{
                //    "Cache-Control",
                //    "max-age=0"
                //},
                {
                    "Referer",
                    "https://pret.currenex.com/webadmin/index.action"
                }//,
                //{
                //    "X-Requested-With",
                //    "XMLHttpRequest"
                //},
            };

            WebClientEx.Headers.Clear();
            WebClientEx.Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"currentDate", "08/04/2014"},
                {"pageIndex", "0"},
                {"view", "HTML"},
                {"fromDateStr", "08/01/2014"},
                {"toDateStr", "08/01/2014"},
                {"selectedAccountId", ""},
                {"selectReport", "Trade Report"}
                };

            // Post Values
            var response = WebClientEx.UploadValues("https://pret.currenex.com/webadmin/report/viewTradeReport.action", values); 
            var responseString = Encoding.Default.GetString(response); 

            //Get CSV
            responseString =
                WebClientEx.DownloadString("https://pret.currenex.com/webadmin/report/viewReport.action?view=CSV");

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
            WebClientEx.Headers.Clear();
            WebClientEx.Headers.Add(headers);

            result = WebClientEx.DownloadString("https://pret.currenex.com/webadmin/logout.action");
            result.Should().Contain("Logged out successfully");
        }
    }

    /// <summary>
    /// http://stackoverflow.com/questions/2066489/how-can-you-add-a-certificate-to-webclient-c
    /// http://stackoverflow.com/questions/6502581/how-to-maintaine-cookies-in-between-two-urls-in-asp-net
    /// http://stackoverflow.com/questions/17840825/cryptographicexception-was-unhandled-system-cannot-find-the-specified-file
    /// </summary>
    public class WebClientEx : WebClient
    {
        public CookieContainer CookieContainer { get; private set; }

        public WebClientEx()
        {
            CookieContainer = new CookieContainer();
        }

        protected override WebRequest GetWebRequest(Uri address)
        {
            var request = (HttpWebRequest)base.GetWebRequest(address);
            if (request != null)
            {
                request.ClientCertificates.Add(new X509Certificate2("Certificates\\pret.pfx", "password", X509KeyStorageFlags.MachineKeySet));
                request.CookieContainer = CookieContainer;
            }
            return request;
        }
    }

//using (var client = new WebClientEx())
//{
//    var values = new NameValueCollection
//    {
//        { "username", "santhu" },
//        { "password", "welcome" },
//    };
//    // Authenticate
//    client.UploadValues("http://172.16.xx.xxx:8080/cms?login", values);

//    // Download some secure resource
//    var result = client.DownloadString("http://172.16.xx.xxx:8080//cms?status=ProcessStatus");
//}
}
