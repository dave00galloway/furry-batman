using System;
using System.Collections.Specialized;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.QDF.Test.Domain.WebClients
{
    public class CurrenexHubAdminWebClient : WebClientEx
    {
        public CurrenexHubAdminWebClient(string certificatesPretPfx, string password)
            : base(certificatesPretPfx, password)
        {
        }

        public void Login(string userName, string password, string url = "https://pret.currenex.com")
        {
            var headers = new NameValueCollection
            {
                {
                    "user-agent",
                    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
                },
                {
                    "Origin",
                    url
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
                    //"https://pret.currenex.com/webadmin/index.action"
                    String.Format("{0}/webadmin/index.action",url)
                }
            };
            Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"e2ee", ""},
                {"username", userName},
                {"password", password},
                {"loginsource", ""}
            };

            // Authenticate
            //CurrenexHubAdminWebClient.UploadValues("https://pret.currenex.com/webadmin/loginAction.action", values);
            UploadValues(String.Format("{0}/webadmin/loginAction.action", url), values);
        }

        public string DownloadTradeActivityReportAsCsv(string currentDate, string fromDate, string toDate, string url = "https://pret.currenex.com")
        {
            var headers = new NameValueCollection
            {
                {
                    "user-agent",
                    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
                },
                {
                    "Origin",
                    url
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
                    "Referer",
                    //"https://pret.currenex.com/webadmin/index.action"
                    String.Format("{0}/webadmin/index.action",url)
                }
            };

            Headers.Clear();
            Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"currentDate", currentDate},
                {"pageIndex", "0"},
                {"view", "HTML"},
                {"fromDateStr", fromDate},
                {"toDateStr", toDate},
                {"selectedAccountId", ""},
                {"selectReport", "Trade Report"}
            };

            // Post Values
            //UploadValues("https://pret.currenex.com/webadmin/report/viewTradeReport.action", values);
            UploadValues(String.Format("{0}/webadmin/report/viewTradeReport.action", url), values);

            //Get CSV
            //string responseString = DownloadString("https://pret.currenex.com/webadmin/report/viewReport.action?view=CSV");
            var downloadString = String.Format("{0}/webadmin/report/viewReport.action?view=CSV", url);
            string responseString = DownloadString(downloadString);
            return responseString;
        }

        public string LogOut()
        {
            string result;
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
            Headers.Clear();
            Headers.Add(headers);

            result = DownloadString("https://pret.currenex.com/webadmin/logout.action");
            return result;
        }
    }
}