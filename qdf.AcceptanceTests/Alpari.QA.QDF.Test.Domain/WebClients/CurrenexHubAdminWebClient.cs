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

        public CurrenexHubAdminWebClient(string certificatesPretPfx, string password, string url)
            : base(certificatesPretPfx, password)
        {
            Url = url;
        }

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
                    String.Format("{0}/webadmin/index.action", Url)
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
                    String.Format("{0}/webadmin/index.action", Url)
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
            string downloadString = String.Format("{0}/webadmin/report/viewReport.action?view=CSV", Url);
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

        public IList<string> GetListOfLoginsFromTradeActivityReportPage()
        {
            //var headers = new NameValueCollection
            //{
            //    {
            //        "user-agent",
            //        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
            //    },
            //    {
            //        "Origin",
            //        Url
            //    },
            //    {
            //        "Accept-Encoding",
            //        "gzip,deflate,sdch"
            //    },
            //    {
            //        "Host",
            //        "pret.currenex.com"
            //    },
            //    {
            //        "Accept-Language",
            //        "en-US,en;q=0.8"
            //    },
            //    {
            //        "Content-Type",
            //        "application/x-www-form-urlencoded"
            //    },
            //    {
            //        "Accept",
            //        "text/html, */*; q=0.01"
            //    },
            //    {
            //        "Referer",
            //        String.Format("{0}/webadmin/index.action",Url)
            //    },
            //    {
            //        "X-Requested-With",
            //        "XMLHttpRequest"
            //    }
            //};

            //Headers.Clear();
            //Headers.Add(headers);

            //var values = new NameValueCollection
            //{
            //   // {"currentDate", currentDate},
            //    {"pageIndex", "0"},
            //    {"view", "HTML"},
            //   // {"fromDateStr", fromDate},
            //   // {"toDateStr", toDate},
            //    {"selectedAccountId", ""},
            //    {"selectReport", "Trade Report"}
            //};

            //// Post Values
            ////UploadValues("https://pret.currenex.com/webadmin/report/viewTradeReport.action", values);
            //UploadValues(String.Format("{0}/webadmin/report/viewTradeReport.action", Url), values);
            throw new NotImplementedException();
        }

        public static IEnumerable<string> CleanTradeActivityReportData(string responseString)
        {
            string[] responseLines = responseString.SplitStringIntoLines();
            IEnumerable<string> cleanedLines =
                responseLines.Where(x => !x.Contains("Count:") && !x.Contains("Trade Activities For All accounts From:"));
            return cleanedLines;
        }

        public IList<string> DownloadCleanedTradeActivityReportAndSaveToFile(string fileNamePath, string currentDate,
            string fromDate, string toDate)
        {
            File.Delete(fileNamePath);
            List<string> cleanedLines = DownloadAndCleanTradeActivityReport(currentDate, fromDate, toDate);
            File.WriteAllLines(fileNamePath, cleanedLines);
            return cleanedLines;
        }

        public void DownloadCleanedTradeActivityReportAndSaveToFile(string fileNamePath, string currentDate,
            string fromDate, string toDate, bool append)
        {
            if (!append)
            {
                File.Delete(fileNamePath);
            }
            List<string> cleanedLines = DownloadAndCleanTradeActivityReport(currentDate, fromDate, toDate);
            // if we've got html back as the response, then there was either no data, or the record count was too big
            if (!cleanedLines.Any(x => x.Contains("DOCTYPE HTML PUBLIC")))
            {
                if (append && File.Exists(fileNamePath))
                {
                    cleanedLines.RemoveAt(0);
                    File.AppendAllLines(fileNamePath, cleanedLines);
                }
                else
                {
                    File.WriteAllLines(fileNamePath, cleanedLines);
                }
            }
            else
            {
                foreach (string cleanedLine in cleanedLines.Where(cleanedLine => cleanedLine.Contains("errorMessage")))
                {
                    Console.WriteLine("error getting data for {0}. error message = {1}", fromDate, cleanedLine);
                }
            }
        }

        /// <summary>
        ///     Create an instance of CurrenexHubAdminWebClient using settings from the app.config of the currently executing
        ///     dll/exe
        ///     When used with Specflow this means the dll that contains the step definition of the currently executing step.
        ///     Not sure what happens if the feature is calling a step defin ition from an external assembly
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

        private List<string> DownloadAndCleanTradeActivityReport(string currentDate, string fromDate, string toDate)
        {
            string responseString = DownloadTradeActivityReportAsCsv(currentDate, fromDate,
                toDate);
            List<string> cleanedLines = CleanTradeActivityReportData(responseString).ToList();
            return cleanedLines;
        }

        public List<string> GetConversionRateDataFor(ExportParameters exportParameters)
        {
            IDictionary<string, string> queryParams = exportParameters.QueryParameters;
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
                    String.Format("{0}/webadmin/index.action", Url)
                }
            };

            Headers.Clear();
            Headers.Add(headers);

            var values = new NameValueCollection
            {
                {"dateStr", queryParams[FROM_DATE_STR]},
                {"pageIndex", "0"},
                {"view", ""}
            };

            // Post Values
            UploadValues(String.Format("{0}/webadmin/conversionRatePackage/viewReportWithoutCache.action", Url), values);

            //Get CSV
            string downloadString =
                String.Format("{0}/webadmin/conversionRatePackage/viewReportFromCache.action?view=CSV&dateStr={1}", Url,
                    queryParams[FROM_DATE_STR]);
            string responseString = DownloadString(downloadString);
            return responseString.SplitStringIntoLines().ToList();
        }

        public List<string> GetConversionRateDataForAndSaveToCsv(ExportParameters exportParameters)
        {
            var queryParams = exportParameters.QueryParameters;
            var data = GetConversionRateDataFor(exportParameters);
            var fileNamePath = String.Format("{0}Conversion Rate For {1}.csv", queryParams[OUTPUT_PATH],
                queryParams[FROM_DATE_STR].Replace("/", "-"));
            File.Delete(fileNamePath);
            File.WriteAllLines(fileNamePath, data);
            return data;
        }
    }
}