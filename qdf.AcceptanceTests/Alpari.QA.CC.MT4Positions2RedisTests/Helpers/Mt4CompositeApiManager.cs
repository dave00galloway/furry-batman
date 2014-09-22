using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4CompositeApiManager : IMt4CompositeApiManager
    {
        private IDictionary<int, IMt4CompositeApi> _mt4CompositeApiDictionary;

        public Mt4CompositeApiManager(IDictionary<int, IMt4CompositeApi> mt4CompositeApiDictionary)
        {
            Mt4CompositeApiDictionary = mt4CompositeApiDictionary;
        }

        public IDictionary<int, IMt4CompositeApi> Mt4CompositeApiDictionary
        {
            get { return _mt4CompositeApiDictionary; }
            private set { _mt4CompositeApiDictionary = value; }
        }

        public Mt4ApiConnectionParameters ManagerConnectionParameters { get; set; }

        public IMt4CompositeApi GetMt4CompositeApi(int login)
        {
            IMt4CompositeApi api;
            lock (_mt4CompositeApiDictionary)
            {
                if (!Mt4CompositeApiDictionary.ContainsKey(login))
                {
                    Mt4CompositeApiDictionary[login] = new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>())
                    {
                       ManagerConnectionParameters = ManagerConnectionParameters
                    };
                }
                api = Mt4CompositeApiDictionary[login];
            }
            return api;
        }

        public IMt4CompositeApi GetMt4CompositeApi(string login)
        {
            return GetMt4CompositeApi(Convert.ToInt32(login));
        }

        public void LoadTrades(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            IList<Mt4TradeBulkLoadParameters> parameterSet =
                mt4TradeBulkLoadParameters as IList<Mt4TradeBulkLoadParameters> ?? mt4TradeBulkLoadParameters.ToList();
            int threads = parameterSet.Count();
            if (threads > 1)
            {
                var doneEvents = new ManualResetEvent[threads];
                for (int i = 0; i < threads; i++)
                {
                    doneEvents[i] = new ManualResetEvent(false);
                    var manager = new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>(), doneEvents[i])
                    {
                        ManagerConnectionParameters = ManagerConnectionParameters
                    };
                    ThreadPool.QueueUserWorkItem(manager.LoadTradesInThread, parameterSet[i]);
                }
                WaitHandle.WaitAll(doneEvents);
            }
            else
            {
                IMt4CompositeApi api = GetMt4CompositeApi(parameterSet.First().Login);
                api.StoreTradeResult(parameterSet.First(),
                    api.LoadTrades(parameterSet.First()));
            }
        }
    }
}