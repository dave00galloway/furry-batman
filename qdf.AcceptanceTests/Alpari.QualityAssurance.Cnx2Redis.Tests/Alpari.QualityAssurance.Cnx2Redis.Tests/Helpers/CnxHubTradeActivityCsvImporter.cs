using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public class CnxHubTradeActivityCsvImporter : ICnxHubTradeActivityImporter
    {
        public List<CnxTradeActivity> CnxTradeActivityList { get; set; }
        public DateTime EarliestTradeActivityDateTime { get; set; }
        public DateTime LatestTradeActivityDateTime { get; set; }
        public IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }

        public void LoadData()
        {
            throw new NotImplementedException();
        }

        public void LoadData(ExportParameters importParameters)
        {
            SetupCnxTradeActivityList(importParameters);
            //TODO:- if more implementations of ICnxHubTradeActivityImporter are created, then move the method calls below to an extension class for ICnxHubTradeActivityImporter
            CnxTradeActivityList.Sort((t1, t2) => DateTime.Compare(t1.TradeDateGMT, t2.TradeDateGMT));
            if (CnxTradeActivityList.Count <= 0) return;
            // ReSharper disable PossibleNullReferenceException
            EarliestTradeActivityDateTime = CnxTradeActivityList.FirstOrDefault().TradeDateGMT;
            LatestTradeActivityDateTime = CnxTradeActivityList.LastOrDefault().TradeDateGMT;
            // ReSharper restore PossibleNullReferenceException
        }

        private void SetupCnxTradeActivityList(ExportParameters importParameters)
        {
            CnxTradeActivityList = IncludedLoginsList == null || !IncludedLoginsList.Any()
                ? importParameters.FileName.CsvToList<CnxTradeActivity>(",")
                : importParameters.FileName.CsvToList<CnxTradeActivity>(",").Where(
                    cnxTradeActivity =>
                        IncludedLoginsList.Any(includedLogin => cnxTradeActivity.Taker == includedLogin.Login)).ToList();
        }
    }
}