using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.QDF.Test.Domain.WebClients
{
    public class CurrenexHubAdminWebClient : WebClientEx
    {
        public CurrenexHubAdminWebClient(string certificatesPretPfx, string password, string url)
            : base(certificatesPretPfx, password)
        {
            Url = url;
        }

        protected const string CNX_HUBADMIN_CERTIFICATE = "cnxHubAdminCertificate";
        protected const string CNX_HUBADMIN_CERTIFICATE_PASSWORD = "cnxHubAdminCertificatePassword";
        protected const string CNX_HUBADMIN_URL = "cnxHubAdminUrl";
        public const string CNX_HUB_ADMIN_USER_NAME = "cnxHubAdminUserName";
        public const string CNX_HUB_ADMIN_PASSWORD = "cnxHubAdminPassword";
        public const string CURRENT_DATE = "currentDate";
        public const string FROM_DATE_STR = "fromDateStr";
        public const string TO_DATE_STR = "toDateStr";
        public const string OUTPUT_PATH = "outputPath";

        public readonly string Url;

        public void Login(string userName, string password)
        {
            var headers = new NameValueCollection
            {
                {
                    "user-agent",
                    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
                },
                {
                    "Origin",
                    Url
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
                    String.Format("{0}/webadmin/index.action",Url)
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
            UploadValues(String.Format("{0}/webadmin/loginAction.action", Url), values);
        }

        public string DownloadTradeActivityReportAsCsv(string currentDate, string fromDate, string toDate)
        {
            var headers = new NameValueCollection
            {
                {
                    "user-agent",
                    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
                },
                {
                    "Origin",
                    Url
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
                    String.Format("{0}/webadmin/index.action",Url)
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
            UploadValues(String.Format("{0}/webadmin/report/viewTradeReport.action", Url), values);

            //Get CSV
            //string responseString = DownloadString("https://pret.currenex.com/webadmin/report/viewReport.action?view=CSV");
            var downloadString = String.Format("{0}/webadmin/report/viewReport.action?view=CSV", Url);
            string responseString = DownloadString(downloadString);
            return responseString;
        }

        public string LogOut()
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

            string result = DownloadString("https://pret.currenex.com/webadmin/logout.action");
            return result;
        }

        public static IEnumerable<string> CleanTradeActivityReportData(string responseString)
        {
            var responseLines = responseString.SplitStringIntoLines();
            var cleanedLines =
                responseLines.Where(x => !x.Contains("Count:") && !x.Contains("Trade Activities For All accounts From:"));
            return cleanedLines;
        }

        public IList<string> DownloadCleanedTradeActivityReportAndSaveToFile(string fileNamePath, string currentDate, string fromDate, string toDate)
        {
            File.Delete(fileNamePath);
            var responseString = DownloadTradeActivityReportAsCsv(currentDate, fromDate,
                toDate);
            var cleanedLines = CleanTradeActivityReportData(responseString).ToList();
            File.WriteAllLines(fileNamePath, cleanedLines);
            return cleanedLines;
        }

        /// <summary>
        /// Create an instance of CurrenexHubAdminWebClient using settings from the app.config of the currently executing dll/exe
        /// When used with Specflow this means the dll that contains the step definition of the currently executing step. 
        /// Not sure what happens if the feature is calling a step defin ition from an external assembly
        /// </summary>
        /// <returns></returns>
        public static CurrenexHubAdminWebClient Create()
        {
            // create a new instance of WebClient
            var currenexHubAdminWebClient =
                new CurrenexHubAdminWebClient(ConfigurationManager.AppSettings[CNX_HUBADMIN_CERTIFICATE],
                    ConfigurationManager.AppSettings[CNX_HUBADMIN_CERTIFICATE_PASSWORD],
                    ConfigurationManager.AppSettings[CNX_HUBADMIN_URL]);
            return currenexHubAdminWebClient;
        }
    }
}