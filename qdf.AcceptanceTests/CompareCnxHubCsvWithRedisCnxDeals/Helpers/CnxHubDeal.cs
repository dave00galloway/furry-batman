
using System;
using Alpari.QDF.UIClient.App.Annotations;

namespace CompareCnxHubCsvWithRedisCnxDeals.Helpers
{
    public class CnxHubDeal
    {
// ReSharper disable InconsistentNaming
        [UsedImplicitly]
        public string TradeID { get; set; }

        [UsedImplicitly]
        public string BuySell { get; set; }

        [UsedImplicitly]
        public string CurrencyPair { get; set; }

        [UsedImplicitly]
        public string Currency { get; set; }

        [UsedImplicitly]
        public decimal Amount { get; set; }
        
        [UsedImplicitly]
        public decimal Rate { get; set; }

        [UsedImplicitly]
        public string Taker { get; set; }

        [UsedImplicitly]
        public DateTime TradeDateGMT { get; set; }

        [UsedImplicitly]
        public string PositionID { get; set; }

        [UsedImplicitly]
        public string PositionType { get; set; }

        [UsedImplicitly]
        public string Comments { get; set; }

        [UsedImplicitly]
        public string SettlementDate { get; set; }
// ReSharper restore InconsistentNaming

    }
}
