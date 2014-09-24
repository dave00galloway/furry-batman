using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4CompositeApiManager : IMt4CompositeApiManager
    {
        //private readonly object _syncLock = new object();

        public Mt4CompositeApiManager(IDictionary<int, IMt4CompositeApi> mt4CompositeApiDictionary)
        {
            Mt4CompositeApiDictionary = mt4CompositeApiDictionary;
        }

        public IDictionary<int, IMt4CompositeApi> Mt4CompositeApiDictionary { get; private set; }

        public Mt4ApiConnectionParameters ManagerConnectionParameters { get; set; }

        public IMt4CompositeApi GetMt4CompositeApi(int login)
        {
            //lock (_syncLock)
            //{
                if (!Mt4CompositeApiDictionary.ContainsKey(login))
                {
                    Mt4CompositeApiDictionary[login] = new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>())
                    {
                        ManagerConnectionParameters = ManagerConnectionParameters
                    };
                }
                var api = Mt4CompositeApiDictionary[login];
            //}
            return api;
        }

        public IMt4CompositeApi GetMt4CompositeApi(string login)
        {
            return GetMt4CompositeApi(Convert.ToInt32(login));
        }

        public void LoadTrades(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            int threads;
            IList<Mt4TradeBulkLoadParameters> parameterSet = ListParameterSet(mt4TradeBulkLoadParameters, out threads);
            if (threads > 1)
            {
                ////traditional method of parallising a task , 280.0s
                //var doneEvents = new ManualResetEvent[threads];
                //for (int i = 0; i < threads; i++)
                //{
                //    doneEvents[i] = new ManualResetEvent(false);
                //    //var manager = new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>(), doneEvents[i])
                //    //{
                //    //    ManagerConnectionParameters = ManagerConnectionParameters
                //    //};
                //    IMt4CompositeApi manager = GetMt4CompositeApi(parameterSet[i].Login);
                //    //manager.ManagerConnectionParameters = ManagerConnectionParameters;
                //    ThreadPool.QueueUserWorkItem(manager.LoadTradesInThread, parameterSet[i]);
                //}
                //WaitHandle.WaitAll(doneEvents);

                ////TPL method , 485s, 402s, 417.1s, 333.7, 197 when running from nunit, but sometimes locks
                //Parallel.ForEach(parameterSet, p =>
                //{
                //    var api = GetMt4CompositeApi(p.Login);
                //    api.StoreTradeResult(p,
                //        api.LoadTrades(p));
                //}
                //    );

                var apis = CreateListOfApisKeyedByParameters(parameterSet);

                Parallel.ForEach(apis, p =>
                {
                    var api = WaitForApiToBeFree(apis, p);
                    api.Value.InUse = true;
                    api.Value.StoreTradeResult(p.Key, api.Value.LoadTrades(p.Key));
                    api.Value.InUse = false;
                }
                    );
            }
            else
            {
                IMt4CompositeApi api = GetMt4CompositeApi(parameterSet.First().Login);
                api.StoreTradeResult(parameterSet.First(),
                    api.LoadTrades(parameterSet.First()));
            }
        }

        public void BulkClosePositions(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            int threads;
            IList<Mt4TradeBulkLoadParameters> parameterSet = ListParameterSet(mt4TradeBulkLoadParameters, out threads);
            var apis = CreateListOfApisKeyedByParameters(parameterSet);
            if (threads > 1)
            {
                Parallel.ForEach(apis, p =>
                {
                    var api = WaitForApiToBeFree(apis, p);
                    api.Value.InUse = true;
                    api.Value.ClosePositionsFor(p.Key.Login);
                    api.Value.InUse = false;
                });
            }
            else
            {
                IMt4CompositeApi api = GetMt4CompositeApi(parameterSet.First().Login);
                api.ClosePositionsFor(parameterSet.First().Login);
            }
        }

        private static KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> WaitForApiToBeFree(List<KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>> apis, KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> p)
        {
            var api = apis.FirstOrDefault(a => a.Key.Login == p.Key.Login);
            while (api.Value.InUse)
            {
                Thread.Sleep(500);
            }
            return api;
        }

        /// <summary>
        /// </summary>
        /// <param name="mt4TradeBulkLoadParameters"></param>
        /// <param name="threads"></param>
        /// <returns></returns>
        private static IList<Mt4TradeBulkLoadParameters> ListParameterSet(
            IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters, out int threads)
        {
            IList<Mt4TradeBulkLoadParameters> parameterSet =
                mt4TradeBulkLoadParameters as IList<Mt4TradeBulkLoadParameters> ?? mt4TradeBulkLoadParameters.ToList();
            threads = parameterSet.Count();
            return parameterSet;
        }

        /// <summary>
        /// enumerate apis first, then execute the loads
        /// note storing in a list of key value pairs to allow duplicate rows to be processed.
        /// would be faster to use a dictionary, but would need to add an additional key value to distinguish between different instances using the same login
        /// </summary>
        /// <param name="parameterSet"></param>
        /// <returns></returns>
        private List<KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>> CreateListOfApisKeyedByParameters(IList<Mt4TradeBulkLoadParameters> parameterSet)
        {
            return 
                parameterSet.Select(
                    parameter =>
                        new KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>(parameter,
                            GetMt4CompositeApi(parameter.Login))).ToList();
        }
    }
}