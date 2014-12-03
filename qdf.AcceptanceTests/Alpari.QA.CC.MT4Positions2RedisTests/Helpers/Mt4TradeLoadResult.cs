using System.Collections.Generic;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    /// <summary>
    /// can be used to show the list of trade ids before and after loading a set of trades
    /// could be used either for positions or trades
    /// </summary>
    public class Mt4TradeLoadResult
    {
        public List<int> PreLoadTradeList { get; set; }
        public List<int> PostLoadTradeList { get; set; }
    }
}
