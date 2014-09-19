using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Threading;
using Alpari.QA.ProcessRunner;
using AlpariUK.Mt4.Wrapper;
using AlpariUK.Mt4.Wrapper.Enums;

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

        public Mt4CompositeApi(IDictionary<string, Mt4TradeLoadResult> mt4TradeLoadResultDictionary)
        {
            Mt4TradeLoadResultDictionary = mt4TradeLoadResultDictionary;
        }

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
                var manager = new Manager(ManagerConnectionParameters.Server, ManagerConnectionParameters.Login,
                    ManagerConnectionParameters.Password))
            {
                try
                {
                    manager.Connect();

                    if (mt4TradeBulkLoadParameters.Login > 0)
                    {
                        //get existing open positions
                        result.PreLoadTradeList = GetOpenPositionOrderIdsForLogin(mt4TradeBulkLoadParameters.Login,
                            manager);
                        //create a process for entering trades
                        ProcessStartInfoWrapper mt4StartInfoWrapper =
                            CreateMt4StartInfoWrapper(mt4TradeBulkLoadParameters);
                        using (var mt4TradeExe = new ProcessRunner.ProcessRunner(mt4StartInfoWrapper))
                        {
                            try
                            {
                                for (int i = 0; i < mt4TradeBulkLoadParameters.Quantity; i++)
                                {
                                    mt4TradeExe.SendInput(mt4TradeBulkLoadParameters.TradeInstruction);
                                }
                                //sync on trades being detected in Manager API
                                var stopwatch = new Stopwatch();
                                stopwatch.Start();
                                while (stopwatch.ElapsedMilliseconds <=
                                       mt4TradeBulkLoadParameters.Quantity*TRADE_INSERT_TIMEOUT)
                                {
                                    result.PostLoadTradeList =
                                        GetOpenPositionOrderIdsForLogin(mt4TradeBulkLoadParameters.Login,
                                            manager);
                                    if (result.PostLoadTradeList.Count - result.PreLoadTradeList.Count >=
                                        mt4TradeBulkLoadParameters.Quantity)
                                    {
                                        Console.WriteLine("{0} trades entered for {1}",
                                            mt4TradeBulkLoadParameters.Quantity, mt4TradeBulkLoadParameters.Login);
                                        break;
                                    }
                                    Thread.Sleep(TRADE_INSERT_TIMEOUT/1000);
                                }
                            }
                            finally
                            {
                                mt4TradeExe.SendInput("exit");
                            }
                        }
                    }
                    else
                    {
                        throw new NotImplementedException("obtaining login from file is not supported yet");
                    }
                }
                finally
                {
                    manager.Disconnect();
                }
            }
            return result;
        }

        public void StoreTradeResult(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters, Mt4TradeLoadResult mt4TradeLoadResult)
        {
            Mt4TradeLoadResultDictionary[mt4TradeBulkLoadParameters.Login.ToString(CultureInfo.InvariantCulture)] = mt4TradeLoadResult;
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

        private static List<int> GetOpenPositionOrderIdsForLogin(int login, Manager manager)
        {
            return
                manager.TradesRequest()
                    .Where(
                        t => t.Login == login && (t.Cmd != TradeCommand.OP_BALANCE || t.Cmd != TradeCommand.OP_CREDIT))
                    .Select(t => t.Order)
                    .ToList();
        }
    }
}