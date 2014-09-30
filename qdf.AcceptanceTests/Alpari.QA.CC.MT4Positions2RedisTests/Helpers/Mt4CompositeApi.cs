using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using Alpari.QA.ProcessRunner;
using AlpariUK.Mt4.Wrapper;
using AlpariUK.Mt4.Wrapper.Enums;
using AlpariUK.Mt4.Wrapper.Types;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4CompositeApi : IMt4CompositeApi
    {
        private const string AUT_MT4_TRADE_MT4_TRADE_EXE = @"AUT\MT4Trade\MT4Trade.exe";
        private const string TRADER_PASSWORD = "Trader";

        /// <summary>
        ///     The maximum time any individual trade should need in order to be inserted into MT4
        /// </summary>
        private const int TRADE_INSERT_TIMEOUT = 5000;

        private const string CLOSE_TRADE_MESSAGE = "close id={0}";
        private const string QUIT_MT4_TRADE_EXE_MESSAGE = "exit";
        private const string CLOSE_ALL_MESSAGE = "close_all";
        private const double REDUCE_TRADE_LOAD_TIMOUT_FACTOR = 6.5;
        private readonly object _inUseSync = new object();
        private bool _inUse;

        public Mt4CompositeApi(IDictionary<string, Mt4TradeLoadResult> mt4TradeLoadResultDictionary)
        {
            Mt4TradeLoadResultDictionary = mt4TradeLoadResultDictionary;
        }

        public Mt4CompositeApi(Dictionary<string, Mt4TradeLoadResult> mt4TradeLoadResultDictionary,
            ManualResetEvent doneEvent)
        {
            Mt4TradeLoadResultDictionary = mt4TradeLoadResultDictionary;
            DoneEvent = doneEvent;
        }

        //public Mt4CompositeApi()
        //{
        //    throw new NotImplementedException();
        //}

        private ManualResetEvent DoneEvent { get; set; }

        /// <summary>
        ///     Assumming we'll only need one set of manager connection parameters,
        ///     and we'll create and drop the connection when needed
        /// </summary>
        public Mt4ApiConnectionParameters ManagerConnectionParameters { get; set; }

        public IDictionary<string, Mt4TradeLoadResult> Mt4TradeLoadResultDictionary { get; set; }

        /// <summary>
        ///     loads a bulk of trades into MT4 for a single login, obtained either directly from parameters, or from a csv file
        ///     an overload should be developed which can load for an array of logins (in parallel?) and return a list of
        ///     Mt4TradeLoadResult
        ///     linked to logins
        /// </summary>
        /// <param name="mt4TradeBulkLoadParameters"></param>
        /// <returns></returns>
        public Mt4TradeLoadResult LoadTrades(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters)
        {
            var result = new Mt4TradeLoadResult();
            using (
                Manager manager = SetupManager())
            {
                try
                {
                    //InUse = false;
                    ConnectManagerAndWaitForConnection(manager);
                    if (mt4TradeBulkLoadParameters.Login > 0)
                    {
                        //get existing open positions
                        result.PreLoadTradeList = GetOpenPositionOrderIdsForLogin(mt4TradeBulkLoadParameters.Login,
                            manager);
                        //create a process for entering trades
                        ProcessStartInfoWrapper mt4StartInfoWrapper =
                            CreateMt4StartInfoWrapper(mt4TradeBulkLoadParameters);
                        BulkLoadIdenticalTradesUsingMt4TradeExeAndSyncOnResult(mt4TradeBulkLoadParameters,
                            mt4StartInfoWrapper, result, manager);
                    }
                    else
                    {
                        throw new NotImplementedException("obtaining login from file is not supported yet");
                    }
                }
                finally
                {
                    manager.Disconnect();
                    //InUse = false;
                }
            }
            return result;
        }

        public void StoreTradeResult(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters,
            Mt4TradeLoadResult mt4TradeLoadResult)
        {
            //InUse = true;
            Mt4TradeLoadResultDictionary[mt4TradeBulkLoadParameters.Login.ToString(CultureInfo.InvariantCulture)] =
                mt4TradeLoadResult;
            //InUse = false;
        }

        /// <summary>
        ///     Close all positions for a specified login
        /// </summary>
        /// <param name="login"></param>
        public void ClosePositionsFor(int login)
        {
            using (Manager manager = SetupManager())
            {
                var result = new Mt4TradeLoadResult();
                var closeParameters = new Mt4TradeBulkLoadParameters { Login = login };
                try
                {
                    //InUse = true;
                    ConnectManagerAndWaitForConnection(manager);
                    //CloseAllPositionsForLoginWithManagerApi(login, manager);
                    //get existing open positions
                    result.PreLoadTradeList = GetOpenPositionOrderIdsForLogin(login,
                        manager);
                    if (result.PreLoadTradeList.Count>0)
                    {
                        //create a process for closing trades
                        using (
                            var mt4TradeExe =
                                new ProcessRunner.ProcessRunner(
                                    CreateMt4StartInfoWrapper(closeParameters)))
                        {
                            try
                            {
                                //PartialCloseAllTradesIndividually(result, mt4TradeExe);
                                mt4TradeExe.SendInput(CLOSE_ALL_MESSAGE);
                                //sync on trades being closed in Manager API
                                var stopwatch = new Stopwatch();
                                stopwatch.Start();
                                while (stopwatch.ElapsedMilliseconds <= result.PreLoadTradeList.Count * TRADE_INSERT_TIMEOUT)
                                {
                                    result.PostLoadTradeList = GetOpenPositionOrderIdsForLogin(login, manager);
                                    if (result.PostLoadTradeList.Count == 0)
                                    {
                                        Console.WriteLine("{0} trades closed for {1}", result.PreLoadTradeList.Count, login);
                                        break;
                                    }
                                    //Thread.Sleep(TRADE_INSERT_TIMEOUT / 1000);
                                    Thread.Sleep(20000);
                                }
                            }
                            finally
                            {
                                CloseMt4TradeExe(mt4TradeExe);
                            }
                        }

                    }
                    else
                    {
                        Console.WriteLine("No trades to close for {0}", login);
                        result.PostLoadTradeList = result.PreLoadTradeList;
                    }

                }
                finally
                {
                    manager.Disconnect();
                    StoreTradeResult(closeParameters, result);
                    //InUse = false;
                }
            }
        }

        public void LoadTradesInThread(Object threadContext)
        {
            //InUse = true;
            try
            {
                var mt4TradeBulkLoadParameters = threadContext as Mt4TradeBulkLoadParameters;
                StoreTradeResult(mt4TradeBulkLoadParameters,
                    LoadTrades(mt4TradeBulkLoadParameters));
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        public bool InUse
        {
            get
            {
                lock (_inUseSync)
                {
                    return _inUse;
                }
            }
            set
            {
                lock (_inUseSync)
                {
                    _inUse = value;
                }
            }
        }


        private Manager SetupManager()
        {
            return new Manager(ManagerConnectionParameters.Server, ManagerConnectionParameters.Login,
                ManagerConnectionParameters.Password);
        }

        private ProcessStartInfoWrapper CreateMt4StartInfoWrapper(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters)
        {
            return new ProcessStartInfoWrapper
            {
                FileName = AUT_MT4_TRADE_MT4_TRADE_EXE,
                Arguments =
                    String.Format("-s {0} -u {1} -p {2}", ManagerConnectionParameters.Server,
                        mt4TradeBulkLoadParameters.Login, TRADER_PASSWORD),
                UseShellExecute = false,
                RedirectStandardError = true,
                RedirectStandardInput = true,
                RedirectStandardOutput = true,
                CreateNoWindow = true
            };
        }

        private List<int> GetOpenPositionOrderIdsForLogin(int login, Manager manager)
        {
            return
                GetOpenPositionsForLogin(login, manager)
                    .Select(t => t.Order)
                    .ToList();
        }

        private IEnumerable<TradeRecord> GetOpenPositionsForLogin(int login, Manager manager)
        {
            ConnectManagerAndWaitForConnection(manager);
            return manager.TradesRequest()
                .Where(
                    t => t.Login == login && (t.Cmd != TradeCommand.OP_BALANCE || t.Cmd != TradeCommand.OP_CREDIT));
        }

        private void ConnectManagerAndWaitForConnection(Manager manager)
        {
            if (!manager.IsConnected())
            {
                manager.Connect();
                var stopwatch = new Stopwatch();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds >= ManagerConnectionParameters.ConnectionTimeout)
                {
                    if (!manager.IsConnected())
                    {
                        break;
                    }
                    Thread.Sleep(ManagerConnectionParameters.ConnectionTimeout / 200);
                }
            }
        }

        private void BulkLoadIdenticalTradesUsingMt4TradeExeAndSyncOnResult(
            Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters, ProcessStartInfoWrapper mt4StartInfoWrapper,
            Mt4TradeLoadResult result, Manager manager)
        {
            using (var mt4TradeExe = new ProcessRunner.ProcessRunner(mt4StartInfoWrapper))
            {
                try
                {
                    bool insertedOk = false;
                    for (int i = 0; i < mt4TradeBulkLoadParameters.Quantity; i++)
                    {
                        mt4TradeExe.SendInput(mt4TradeBulkLoadParameters.TradeInstruction);
                    }
                    //sync on trades being detected in Manager API
                    var stopwatch = new Stopwatch();
                    stopwatch.Start();
                    while (stopwatch.ElapsedMilliseconds <=
                           (mt4TradeBulkLoadParameters.Quantity * TRADE_INSERT_TIMEOUT) / REDUCE_TRADE_LOAD_TIMOUT_FACTOR)
                    {
                        insertedOk = CheckTradeInsertion(mt4TradeBulkLoadParameters, result, manager);
                        if (insertedOk) break;
                        Thread.Sleep(TRADE_INSERT_TIMEOUT / 10000);
                    }
                    if (!insertedOk && !CheckTradeInsertion(mt4TradeBulkLoadParameters, result, manager))
                    {
                        throw new TimeoutException(
                            String.Format("Trade load failed for {0} after {1} milliseconds, {2} trades were loaded",
                                mt4TradeBulkLoadParameters.Login, stopwatch.ElapsedMilliseconds,
                                result.PostLoadTradeList.Count - result.PreLoadTradeList.Count));
                    }
                }
                catch(Exception e)
                {
                    Console.WriteLine(e);
                }
                finally
                {
                    CloseMt4TradeExe(mt4TradeExe);
                }
            }
        }

        private bool CheckTradeInsertion(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters, Mt4TradeLoadResult result,
            Manager manager)
        {
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            while (stopwatch.ElapsedMilliseconds < 10000)
            {
                try
                {
                    result.PostLoadTradeList =
                        GetOpenPositionOrderIdsForLogin(mt4TradeBulkLoadParameters.Login,
                            manager);
                    if (result.PostLoadTradeList.Count - result.PreLoadTradeList.Count >=
                        mt4TradeBulkLoadParameters.Quantity)
                    {
                        Console.WriteLine("{0} trades entered for {1}",
                            mt4TradeBulkLoadParameters.Quantity, mt4TradeBulkLoadParameters.Login);
                        return true;
                    }

                }
                catch (Exception e)
                {
                    Console.WriteLine("Handled Exception thrown while getting trades for login {0}. exception details {1}", mt4TradeBulkLoadParameters.Login, e);
                    //attempting to reconnect the manager doesn't work, so might as well throw exception if disconnected
                    if (!manager.IsConnected())
                    {
                        throw;
                    }
                    //try
                    //{
                    //    manager.Disconnect();
                    //}
                    //catch (Exception exception)
                    //{
                    //    Console.WriteLine(exception);
                    //}
                    //manager.Dispose();
                    //GC.Collect();
                    //Thread.Sleep(500);
                    //manager = SetupManager();
                    //manager.Connect();
                }
            }
            return false;
        }

        private static void CloseMt4TradeExe(ProcessRunner.ProcessRunner mt4TradeExe)
        {
            mt4TradeExe.SendInput(QUIT_MT4_TRADE_EXE_MESSAGE);
        }

        /// <summary>
        ///     run through each trade for a user login and close out 1 lot of volume (or the entie trade if less left)
        /// </summary>
        /// <param name="result"></param>
        /// <param name="mt4TradeExe"></param>
        private static void PartialCloseAllTradesIndividually(Mt4TradeLoadResult result,
            ProcessRunner.ProcessRunner mt4TradeExe)
        {
            foreach (int orderId in result.PreLoadTradeList)
            {
                mt4TradeExe.SendInput(String.Format(CLOSE_TRADE_MESSAGE, orderId));
            }
        }

        [Obsolete(
            "The CloseAll method doesn't work. It doesn't error, but it doesn't close trades either. Leaving in case the API gets fixed"
            )]
        private void CloseAllPositionsForLoginWithManagerApi(int login, Manager manager)
        {
            //get existing open positions
            IEnumerable<TradeRecord> positions = GetOpenPositionsForLogin(login,
                manager);
            //get distinct list of symbols for login
            IEnumerable<string> symbolList = positions.GroupBy(p => p.Symbol).Select(g => g.Key);
            foreach (string symbol in symbolList)
            {
                Console.WriteLine("Closing {0} trades for {1} with symbol {2}", manager.CloseAll(login, symbol), login,
                    symbol);
            }
        }


        //// Wrapper method for use with thread pool.
        //public void ThreadPoolCallback(Object threadContext)
        //{
        //    int threadIndex = (int)threadContext;
        //    Console.WriteLine("thread {0} started...", threadIndex);
        //    //_fibOfN = Calculate(_n);
        //    Console.WriteLine("thread {0} result calculated...", threadIndex);
        //    //_doneEvent.Set();
        //}
    }
}