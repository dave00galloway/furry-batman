using System;
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


        //Can't remeber why this is a string key, seems a bit daft since we're using logins which are ints. maybe change this?
        IDictionary<string, Mt4TradeLoadResult> Mt4TradeLoadResultDictionary { get; set; }

        /// <summary>
        ///     loads a bulk of trades into MT4 for a single login, obtained either directly from parameters, or from a csv file
        ///     an overload should be developed which can load for an array of logins (in parallel?) and return a list of
        ///     Mt4TradeLoadResult
        ///     linked to logins
        /// </summary>
        /// <param name="mt4TradeBulkLoadParameters"></param>
        /// <returns></returns>
        Mt4TradeLoadResult LoadTrades(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters);

        void StoreTradeResult(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters,
            Mt4TradeLoadResult mt4TradeLoadResult);

        /// <summary>
        ///     Close all positions for a specified login
        /// </summary>
        /// <param name="login"></param>
        void ClosePositionsFor(int login);

        void LoadTradesInThread(Object threadContext);

        //bool InUse { get; set; }
    }
}