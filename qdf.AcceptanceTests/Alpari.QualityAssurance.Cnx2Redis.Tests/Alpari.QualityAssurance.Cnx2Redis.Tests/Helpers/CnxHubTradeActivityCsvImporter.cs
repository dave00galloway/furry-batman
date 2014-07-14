using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Steps;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

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
            IgnoreProps = new[] { "PositionID", "PositionType", "SettlementDate" };
            SetupCnxTradeActivityList(importParameters);
            //TODO:- if more implementations of ICnxHubTradeActivityImporter are created, then move the method calls below to an extension class for ICnxHubTradeActivityImporter
            CnxTradeActivityList.Sort((t1, t2) => DateTime.Compare(t1.TradeDateGMT, t2.TradeDateGMT));
            UpdateStartAndEndTimes();
        }

        public void UpdateStartAndEndTimes()
        {
            if (CnxTradeActivityList.Count <= 0) return;
            UpdateTimes();
        }

        public void UpdateStartAndEndTimes(DateTime startDate, DateTime endDate)
        {
            EarliestTradeActivityDateTime = startDate;
            LatestTradeActivityDateTime = endDate;
        }

        public void ReverseDealSide()
        {
            CnxTradeActivityList =
                CnxTradeActivityList.Select(c => new CnxTradeActivity
                {
                    Amount = c.Amount,
                    BuySell =
                        (c.BuySell.ToUpper() == "SELL" || c.BuySell.ToUpper() == "BUY")
                            ? (c.BuySell.ToUpper() == "SELL" ? "BUY" : "SELL")
                            : "NONE",
                    Comments = c.Comments,
                    Currency = c.Currency,
                    CurrencyPair = c.CurrencyPair,
                    Rate = c.Rate,
                    Taker = c.Taker,
                    TradeDateGMT = c.TradeDateGMT,
                    TradeId = c.TradeId
                }
                    ).ToList();
        }

        private void UpdateTimes()
        {
            // ReSharper disable PossibleNullReferenceException
            EarliestTradeActivityDateTime = CnxTradeActivityList.FirstOrDefault().TradeDateGMT;
            LatestTradeActivityDateTime = CnxTradeActivityList.LastOrDefault().TradeDateGMT;
            // ReSharper restore PossibleNullReferenceException
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