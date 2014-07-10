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
                default:
                    throw  new ArgumentException(implementationType);
            }
            return cnxHubTradeActivityImporter;
        }
    }
}