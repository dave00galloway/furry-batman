using System;
using System.Linq;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public static class IcnxHubTradeActivityImporterExtensions
    {
        /// <summary>
        ///     Should really make ignoreProps a property on IcnxHubTradeActivityImporter if this is supposed to be an extension
        ///     class for it...
        /// </summary>
        /// <param name="ignoreProps"></param>
        /// <returns></returns>
        public static string[] SetupIgnoreProps(this string[] ignoreProps)
        {
            ignoreProps = new[] {"PositionID", "PositionType", "SettlementDate"};
            return ignoreProps;
        }

        public static void SortCnxTradeActivityListByDate(this ICnxHubTradeActivityImporter importer)
        {
            importer.CnxTradeActivityList.Sort((t1, t2) => DateTime.Compare(t1.TradeDateGMT, t2.TradeDateGMT));
        }

        public static void UpdateStartAndEndTimesImpl(this ICnxHubTradeActivityImporter importer)
        {
            if (importer.CnxTradeActivityList.Count <= 0) return;
            // ReSharper disable PossibleNullReferenceException
            importer.EarliestTradeActivityDateTime = importer.CnxTradeActivityList.FirstOrDefault().TradeDateGMT;
            importer.LatestTradeActivityDateTime = importer.CnxTradeActivityList.LastOrDefault().TradeDateGMT;
            // ReSharper restore PossibleNullReferenceException
        }

        public static void UpdateStartAndEndTimesImpl(this ICnxHubTradeActivityImporter importer, DateTime startDate,
            DateTime endDate)
        {
            importer.EarliestTradeActivityDateTime = startDate;
            importer.LatestTradeActivityDateTime = endDate;
        }

        public static void ReverseDealSideImpl(this ICnxHubTradeActivityImporter importer)
        {
            importer.CnxTradeActivityList =
                importer.CnxTradeActivityList.Select(c => new CnxTradeActivity
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
    }
}