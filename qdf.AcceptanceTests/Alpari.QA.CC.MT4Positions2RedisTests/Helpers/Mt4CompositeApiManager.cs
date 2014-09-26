using System;
using System.Collections.Generic;
using System.Diagnostics;
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
            IMt4CompositeApi api = Mt4CompositeApiDictionary[login];
            //}
            return api;
        }

        public IMt4CompositeApi GetMt4CompositeApi(string login)
        {
            return GetMt4CompositeApi(Convert.ToInt32(login));
        }
        
        public void LoadTrades(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            IList<Mt4TradeBulkLoadParameters> parameterSet = mt4TradeBulkLoadParameters.ToList();// ListParameterSet(mt4TradeBulkLoadParameters, out threads);
            int threads = parameterSet.Count;

            if (threads > 1)
            {
                #region attempt at using semaphore to throttle 'thread' creation
                AsyncLoadTradesInApi(parameterSet, 300);
                //const int MAX_DOWNLOADS = 50;

                //static async Task DownloadAsync(string[] urls)
                //{
                //    using (var semaphore = new SemaphoreSlim(MAX_DOWNLOADS))
                //    using (var httpClient = new HttpClient())
                //    {
                //        var tasks = urls.Select(async(url) => 
                //        {
                //            await semaphore.WaitAsync();
                //            try
                //            {
                //                var data = await httpClient.GetStringAsync(url);
                //                Console.WriteLine(data);
                //            }
                //            finally
                //            {
                //                semaphore.Release();
                //            }
                //        });

                //        await Task.WhenAll(tasks.ToArray());
                //    }
                //}

                #endregion

                #region sergey's manual thread creation method (so far the quickest, but hangs or crashes)

                //var doneEvent = new ManualResetEvent(false);
                //var doneEvents = new ManualResetEvent[threads];
                //for (int i = 0; i < threads; i++)
                //{
                //    var meCopy = new ManualResetEvent(false);
                //    var iCopy = i;
                //    var th = new Thread(() =>
                //    {
                //        Console.WriteLine("↑:{0}", iCopy);
                //        IMt4CompositeApi manager = //new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>(),meCopy);   
                //                                GetMt4CompositeApi(parameterSet[iCopy].Login);
                //        manager.LoadTradesInThread(parameterSet[iCopy]);

                //        Console.WriteLine("↓:{0}", iCopy);
                //        //meCopy.Set();

                //        if (Interlocked.Decrement(ref threads) == 0)
                //        {
                //            doneEvent.Set();
                //        }

                //        Console.WriteLine("→:{0}", iCopy);
                //    });

                //    th.Start();
                //    doneEvents[iCopy] = meCopy;
                //}

                //Console.WriteLine("done events: {0} - {1}", doneEvents.Length, doneEvents.Where(e => e != null).Count());

                //doneEvent.WaitOne();

                #endregion

                #region ThreadPool method

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

                #endregion

                #region basic tpl method

                ////TPL method , 485s, 402s, 417.1s, 333.7, 197 when running from nunit, but sometimes locks
                //Parallel.ForEach(parameterSet, p =>
                //{
                //    var api = GetMt4CompositeApi(p.Login);
                //    api.StoreTradeResult(p,
                //        api.LoadTrades(p));
                //}
                //    );

                #endregion

                #region slightly improved tpl method, but still sometimes hangs

                //Parallel.ForEach(apis,parallelOptions, p =>
                //{
                //    KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> api = WaitForApiToBeFree(apis, p);
                //    if (api.Key == null) return;
                //    api.Value.InUse = true;
                //    api.Value.StoreTradeResult(p.Key, api.Value.LoadTrades(p.Key));
                //    api.Value.InUse = false;
                //}
                //    );

                #endregion

                #region attempt at using parallel options to govern failed processes/threads

                //var parallelOptions = ParallelOptionsCancellationWatchdog(parameterSet);

                //var maxTimeout = parameterSet.Sum(p => (p.Quantity > 0 ? p.Quantity : 1)) * 1;
                //var stopwatch = new Stopwatch();
                //stopwatch.Start();
                //Task.Factory.StartNew(() =>
                //{
                //    while (stopwatch.ElapsedMilliseconds < maxTimeout / 2)
                //    {
                //        Thread.Sleep(10000);
                //    }
                //    Console.WriteLine("About to cancel thread");
                //    parallelOptions.cancellationTokenSource.Cancel();
                //});

                //var apis =
                //    CreateListOfApisKeyedByParameters(parameterSet);

                //Parallel.ForEach(apis,parallelOptions, p =>
                //{
                //    parallelOptions.CancellationToken.ThrowIfCancellationRequested();
                //    KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> api = WaitForApiToBeFree(apis, p);
                //    if (api.Key == null) return;
                //    api.Value.InUse = true;
                //    api.Value.StoreTradeResult(p.Key, api.Value.LoadTrades(p.Key));
                //    api.Value.InUse = false;
                //    parallelOptions.CancellationToken.ThrowIfCancellationRequested();
                //}
                //    );
                //parallelOptions.CancellationToken.

                #endregion
            }
            else
            {
                IMt4CompositeApi api = GetMt4CompositeApi(parameterSet.First().Login);
                api.StoreTradeResult(parameterSet.First(),
                    api.LoadTrades(parameterSet.First()));
            }
        }

        ///// <summary>
        ///// //http://stackoverflow.com/questions/22492383/throttling-asynchronous-tasks
        ///// Doesn't work - only allows one thread at a time
        ///// </summary>
        ///// <param name="parameterSet"></param>
        ///// <param name="threads"></param>
        ///// <param name="i"></param>
        ///// <returns></returns>
        //private async Task AsyncLoadTradesInApi(IList<Mt4TradeBulkLoadParameters> parameterSet, int threads, int i)
        //{
        //    using (var semaphore = new SemaphoreSlim(i))
        //    {
        //        var tasks = parameterSet.Select(async parameter =>
        //        {
        //            await semaphore.WaitAsync();
        //            try
        //            {
        //                IMt4CompositeApi manager = GetMt4CompositeApi(parameter.Login);
        //                manager.LoadTradesInThread(parameter);
        //            }
        //            finally
        //            {
        //                semaphore.Release();
        //            }
        //        });

        //        await Task.WhenAll(tasks.ToArray());
        //    }
        //}

        /// <summary>
        /// //http://blog.cincura.net/233438-semaphoreslims-waitasync-puzzle/
        /// 
        /// </summary>
        /// <param name="parameterSet"></param>
        /// <param name="i"></param>
        /// <returns></returns>
        private void AsyncLoadTradesInApi(IList<Mt4TradeBulkLoadParameters> parameterSet, int i)
        {
            try
            {
                using (var semaphore = new SemaphoreSlim(i,i))
                {
                    var tasks = parameterSet.Select(async parameter =>
                    {
                        await Task.Yield();
                        await ProcessAsyncTradeLoad(semaphore, parameter).ConfigureAwait(false);
                    }).ToArray();
                    Task.WaitAll(tasks);
                }
            }
            catch (AggregateException aggregateException)
            {
                //aggregateException.Handle(exception =>
                //{
                    
                //}
                //    );
                Console.WriteLine(aggregateException.Flatten().ToString());
                //Console.WriteLine(aggregateException);
            }
        }

        private async Task ProcessAsyncTradeLoad(SemaphoreSlim semaphore, Mt4TradeBulkLoadParameters parameter)
        {
            await semaphore.WaitAsync().ConfigureAwait(false);
            try
            {
                IMt4CompositeApi manager = GetMt4CompositeApi(parameter.Login);
                manager.LoadTradesInThread(parameter);
            }
            finally
            {
                semaphore.Release();
                GC.Collect();
            }
        }

        public void BulkClosePositions(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            int threads;
            IList<Mt4TradeBulkLoadParameters> parameterSet = ListParameterSet(mt4TradeBulkLoadParameters, out threads);
            List<KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>> apis =
                CreateListOfApisKeyedByParameters(parameterSet);

            //IList<Mt4TradeBulkLoadParameters> parameterSet = mt4TradeBulkLoadParameters.ToList();
            //int threads = parameterSet.Count;
            if (threads > 1)
            {
                #region basic TPL method (reliable for this scenario but slow)
                Parallel.ForEach(apis, p =>
                {
                    KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> api = WaitForApiToBeFree(apis, p);
                    if (api.Key == null) return;
                    api.Value.InUse = true;
                    api.Value.ClosePositionsFor(p.Key.Login);
                    api.Value.InUse = false;
                });
                #endregion 

                #region based on sergey's manual thread method - fast but crashy
                //var doneEvent = new ManualResetEvent(false);
                //var doneEvents = new ManualResetEvent[threads];
                //for (int i = 0; i < threads; i++)
                //{
                //    var meCopy = new ManualResetEvent(false);
                //    var iCopy = i;
                //    var th = new Thread(() =>
                //    {
                //        Console.WriteLine("↑:{0}", iCopy);
                //        //KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> api = WaitForApiToBeFree(apis, parameterSet[iCopy].Login);
                //        IMt4CompositeApi manager = //new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>(),meCopy);   
                //                                GetMt4CompositeApi(parameterSet[iCopy].Login);
                //        //if (api.Key == null) return;
                //        //api.Value.InUse = true;
                //        manager.ClosePositionsFor(parameterSet[iCopy].Login);
                //        //api.Value.InUse = false;

                //        Console.WriteLine("↓:{0}", iCopy);
                //        //meCopy.Set();

                //        if (Interlocked.Decrement(ref threads) == 0)
                //        {
                //            doneEvent.Set();
                //        }

                //        Console.WriteLine("→:{0}", iCopy);
                //    });

                //    th.Start();
                //    doneEvents[iCopy] = meCopy;
                //}

                //Console.WriteLine("done events: {0} - {1}", doneEvents.Length, doneEvents.Where(e => e != null).Count());

                //doneEvent.WaitOne();
                #endregion
            }
            else
            {
                IMt4CompositeApi api = GetMt4CompositeApi(parameterSet.First().Login);
                api.ClosePositionsFor(parameterSet.First().Login);
            }
        }

        private static KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> WaitForApiToBeFree(
            IEnumerable<KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>> apis,
            KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi> p, int timeout = 180000)
        {
            var api =
                apis.FirstOrDefault(a => a.Key.Login == p.Key.Login);
            Console.WriteLine("Check for available api for {0} {1} {2} {3} {4} to start", api.Key.Login, api.Key.TradeInstruction, api.Key.Quantity, api.Key.Threads, api.Key.FileNamePath);
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            while (api.Value.InUse && stopwatch.ElapsedMilliseconds < timeout)
            {
                Console.WriteLine("waiting for {0} {1} {2} {3} {4} to start", api.Key.Login, api.Key.TradeInstruction, api.Key.Quantity, api.Key.Threads, api.Key.FileNamePath);
                Thread.Sleep(500);
            }
            if (api.Value.InUse)
            {
                Console.WriteLine("unable to start {0} {1} {2} {3} {4} ", api.Key.Login, api.Key.TradeInstruction, api.Key.Quantity, api.Key.Threads, api.Key.FileNamePath);
                return new KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>(null,null);
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
        ///     enumerate apis first, then execute the loads
        ///     note storing in a list of key value pairs to allow duplicate rows to be processed.
        ///     would be faster to use a dictionary, but would need to add an additional key value to distinguish between different
        ///     instances using the same login
        /// </summary>
        /// <param name="parameterSet"></param>
        /// <returns></returns>
        private List<KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>> CreateListOfApisKeyedByParameters(
            IList<Mt4TradeBulkLoadParameters> parameterSet)
        {
            return
                parameterSet.Select(
                    parameter =>
                        new KeyValuePair<Mt4TradeBulkLoadParameters, IMt4CompositeApi>(parameter,
                            GetMt4CompositeApi(parameter.Login))).ToList();
        }

        /// <summary>
        /// watch a  parallel loop in case of hanging threads etc.
        /// </summary>
        /// <param name="parameterSet"></param>
        /// <param name="operationTimeout">the approx amount of time per operation to wait</param>
        /// <returns></returns>
        private static ParallelOptions ParallelOptionsCancellationWatchdog(IList<Mt4TradeBulkLoadParameters> parameterSet, int operationTimeout = 1
            )
        {
            //
            var cancellationTokenSource = new CancellationTokenSource();
            var parallelOptions = new ParallelOptions
            {
                CancellationToken = cancellationTokenSource.Token,
                MaxDegreeOfParallelism = -1
            };


            return parallelOptions;
        }
    }
}