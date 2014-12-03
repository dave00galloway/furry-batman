using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public class CnxHubTradeActivityCsvImporter : ICnxHubTradeActivityImporter
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
            IgnoreProps = IgnoreProps.SetupIgnoreProps();
            SetupCnxTradeActivityList(importParameters);
            //TODO:- if more implementations of ICnxHubTradeActivityImporter are created, then move the method calls below to an extension class for ICnxHubTradeActivityImporter
            this.SortCnxTradeActivityListByDate();
            UpdateStartAndEndTimes();
        }

        public IList<string> LoadData(string queryName, ExportParameters importParameters)
        {
            throw new NotImplementedException();
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

        /// <summary>
        /// Not currently a useful thing to have for a csv importer, but could be used to join multiple csv files into one if required
        /// </summary>
        /// <param name="importParameters"></param>
        /// <param name="append"></param>
        /// <param name="fileName"></param>
        public void LoadData(ExportParameters importParameters, bool append, string fileName)
        {
            throw new NotImplementedException();
        }

        private void SetupCnxTradeActivityList(ExportParameters importParameters)
        {
            CnxTradeActivityList = IncludedLoginsList == null || !IncludedLoginsList.Any()
                ? importParameters.FileName.CsvToList<CnxTradeActivity>(",", IgnoreProps)
                : importParameters.FileName.CsvToList<CnxTradeActivity>(",", IgnoreProps).Where(
                    cnxTradeActivity =>
                        IncludedLoginsList.Any(includedLogin => cnxTradeActivity.Taker == includedLogin.Login)).ToList();
        }
    }
}