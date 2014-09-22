using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4TradeBulkLoadParameters
    {
        public int Login { get; set; }
        public string TradeInstruction { get; set; }
        public int Quantity { get; set; }
        public string FileNamePath { get; set; }
        /// <summary>
        /// formerly used to control number of threads to create when entering traes multithreaded. May now be redundant
        /// </summary>
        public int Threads { get; set; }
    }
}
