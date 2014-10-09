
namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4TradeBulkLoadParameters
    {
        public int Login { get; set; }
        /// <summary>
        /// use this for repeating the instruction for a specified number of times in certain scenarios
        /// </summary>
        public int StartLogin { get; set; }
        /// <summary>
        /// use this for repeating the instruction for a specified number of times in certain scenarios
        /// </summary>
        public int EndLogin { get; set; }
        public string TradeInstruction { get; set; }
        public int Quantity { get; set; }
        public string FileNamePath { get; set; }
        /// <summary>
        /// Now used to throttle certain bulk load situations
        /// </summary>
        public int Threads { get; set; }
    }
}
