using System.Collections;
using System.Collections.Generic;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public interface IMt4CompositeApi
    {
        /// <summary>
        ///     Assumming we'll only need one set of manager connection parameters, 
        ///     and we'll create and drop the connection when needed
        /// </summary>
        Mt4ApiConnectionParameters ManagerConnectionParameters { get; set; }

        IDictionary<string, Mt4TradeLoadResult> Mt4TradeLoadResultDictionary { get; set; }

        Mt4TradeLoadResult LoadTrades(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters);
        void StoreTradeResult(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters, Mt4TradeLoadResult mt4TradeLoadResult);
        void ClosePositionsFor(int login);
    }
}