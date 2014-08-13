using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public class CnxHubTradeActivityWebClientImporter : ICnxHubTradeActivityImporter
    {
        public List<CnxTradeActivity> CnxTradeActivityList { get; set; }
        public DateTime EarliestTradeActivityDateTime { get; set; }
        public DateTime LatestTradeActivityDateTime { get; set; }
        public IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        private string[] IgnoreProps { get; set; }

        public void LoadData()
        {
            throw new NotImplementedException();
        }

        public void LoadData(ExportParameters importParameters)
        {
            IList<string> data;
            using (var currenexHubAdminWebClient = CurrenexHubAdminWebClient.Create())
            {
                var queryParams = importParameters.QueryParameters;
                //login
                currenexHubAdminWebClient.Login(
                    queryParams[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_USER_NAME],
                    queryParams[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_PASSWORD]);
                //get data
                data = currenexHubAdminWebClient.DownloadCleanedTradeActivityReportAndSaveToFile(
                    String.Format("{0}TradeActivitiesForAllaccountsFrom{1}To{2}.csv",
                    queryParams[CurrenexHubAdminWebClient.OUTPUT_PATH],
                    queryParams[CurrenexHubAdminWebClient.FROM_DATE_STR].Replace("/","-"),
                    queryParams[CurrenexHubAdminWebClient.TO_DATE_STR].Replace("/", "-")
                    )
                    ,
                    queryParams[CurrenexHubAdminWebClient.CURRENT_DATE],
                    queryParams[CurrenexHubAdminWebClient.FROM_DATE_STR],
                    queryParams[CurrenexHubAdminWebClient.TO_DATE_STR]
                    );
                //logout/dispose
                currenexHubAdminWebClient.LogOut();
            }
           //parse into CnxTradeActivity
            SetupCnxTradeActivityList(data);
            this.SortCnxTradeActivityListByDate();
            UpdateStartAndEndTimes();
        }

        /// <summary>
        /// Creates or appends to a csv file using the provided importParameters.
        /// Does not currently save the result to CnxTradeActivityList
        /// </summary>
        /// <param name="importParameters"></param>
        /// <param name="append"></param>
        /// <param name="fileName"></param>
        public void LoadData(ExportParameters importParameters, bool append, string fileName)
        {
            //IList<string> data;
            using (var currenexHubAdminWebClient = CurrenexHubAdminWebClient.Create())
            {
                var queryParams = importParameters.QueryParameters;
                //login
                currenexHubAdminWebClient.Login(
                    queryParams[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_USER_NAME],
                    queryParams[CurrenexHubAdminWebClient.CNX_HUB_ADMIN_PASSWORD]);
                //get data
                currenexHubAdminWebClient.DownloadCleanedTradeActivityReportAndSaveToFile(
                    String.Format("{0}{1}",
                    queryParams[CurrenexHubAdminWebClient.OUTPUT_PATH],
                    fileName
                    )
                    ,
                    queryParams[CurrenexHubAdminWebClient.CURRENT_DATE],
                    queryParams[CurrenexHubAdminWebClient.FROM_DATE_STR],
                    queryParams[CurrenexHubAdminWebClient.TO_DATE_STR]
                    ,
                    append);
                //logout/dispose
                currenexHubAdminWebClient.LogOut();
            }
        }

        private void SetupCnxTradeActivityList(IEnumerable<string> data)
        {
            var enumerable = data as string[] ?? data.ToArray();
            if (enumerable.Any(x=>x.Contains("\t\t<li><span class=\"errorMessage\">No data found for requested input</span></li>")))
            {
                CnxTradeActivityList = new List<CnxTradeActivity>();
            }
            else
            {
                CnxTradeActivityList = IncludedLoginsList == null || !IncludedLoginsList.Any()
                    ? enumerable.UntypedStringArrayToList<CnxTradeActivity>(",", IgnoreProps)
                    : enumerable.UntypedStringArrayToList<CnxTradeActivity>(",", IgnoreProps).Where(
                        cnxTradeActivity =>
                            IncludedLoginsList.Any(includedLogin => cnxTradeActivity.Taker == includedLogin.Login)).ToList();                
            }

        }

        public void UpdateStartAndEndTimes()
        {
            this.UpdateStartAndEndTimesImpl();
        }

        public void UpdateStartAndEndTimes(DateTime startDate, DateTime endDate)
        {
            this.UpdateStartAndEndTimesImpl(startDate, endDate);
        }

        public void ReverseDealSide()
        {
            this.ReverseDealSideImpl();
        }
    }
}