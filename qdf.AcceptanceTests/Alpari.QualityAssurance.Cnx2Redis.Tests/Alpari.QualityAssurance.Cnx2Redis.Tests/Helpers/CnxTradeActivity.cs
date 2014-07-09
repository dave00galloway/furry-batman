using System;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public class CnxTradeActivity   
    {
        //Trade Id
        //Buy/Sell
        //"Currency Pair	"
        //Currency
        //Amount
        //Rate
        //Taker
        //Trade Date (GMT)
        //Comments
        public string TradeId { get; set; }
        public string BuySell { get; set; }
        public string CurrencyPair { get; set; }
        public string Currency { get; set; } //won't use
        public decimal Amount { get; set; }
        public decimal Rate { get; set; }
        public string Taker { get; set; }   //Login
        public DateTime TradeDateGMT { get; set; }
        public string Comments { get; set; } //won't use

    }
}