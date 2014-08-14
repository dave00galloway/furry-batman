using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public interface ICnxHubTradeActivityImporter
    {
        List<CnxTradeActivity> CnxTradeActivityList { get; set; }
        DateTime EarliestTradeActivityDateTime { get; set; }
        DateTime LatestTradeActivityDateTime { get; set; }
        IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        void LoadData();
        void LoadData(ExportParameters importParameters);
        void LoadData(ExportParameters importParameters, bool append, string fileName);

        /// <summary>
        /// use this overload when you want to specify a differnt query other than the main/default query 
        /// </summary>
        /// <param name="queryName"></param>
        /// <param name="importParameters"></param>
        IList<string> LoadData(string queryName, ExportParameters importParameters);
        void UpdateStartAndEndTimes();
        void UpdateStartAndEndTimes(DateTime startDate, DateTime endDate);
        void ReverseDealSide();
    }

    public static class CnxHubTradeActivityImporterFactory
    {
        public static ICnxHubTradeActivityImporter Create(string implementationType)
        {
            implementationType = implementationType.Split(':').LastOrDefault();
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter;
            switch (implementationType)
            {
                case "":
                case ExportParameters.CSV:
                    cnxHubTradeActivityImporter = new CnxHubTradeActivityCsvImporter();
                    break;
                case ExportParameters.WEB_CLIENT:
                    cnxHubTradeActivityImporter = new CnxHubTradeActivityWebClientImporter();
                    break;
                default:
                    throw  new ArgumentException(implementationType);
            }
            return cnxHubTradeActivityImporter;
        }
    }
}