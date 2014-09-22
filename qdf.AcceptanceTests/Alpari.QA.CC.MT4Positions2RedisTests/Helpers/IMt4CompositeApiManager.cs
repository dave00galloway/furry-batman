using System.Collections.Generic;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public interface IMt4CompositeApiManager
    {
        IDictionary<int, IMt4CompositeApi> Mt4CompositeApiDictionary { get;  }
        /// <summary>
        /// currently assuming that all instances of IMt4CompositeApi will share the same connection parameters
        /// May need to add a adictionary if this changes
        /// </summary>
        Mt4ApiConnectionParameters ManagerConnectionParameters { get; set; }

        IMt4CompositeApi GetMt4CompositeApi (int login);
        IMt4CompositeApi GetMt4CompositeApi(string login);
        void LoadTrades(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters);
    }
}