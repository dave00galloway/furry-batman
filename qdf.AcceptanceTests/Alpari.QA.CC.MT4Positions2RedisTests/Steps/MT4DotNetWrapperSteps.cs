﻿using System;
using System.Diagnostics;
using System.Threading;
using Alpari.QA.CC.MT4Positions2RedisTests.Transforms;
using AlpariUK.Mt4.Wrapper;
using AlpariUK.Mt4.Wrapper.Enums;
using AlpariUK.Mt4.Wrapper.Types;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4DotNetWrapperSteps
    {
        public Client Client { get; set; }

        [Given(@"I have a client connection to MT4:-")]
        public void GivenIHaveAClientConnectionToMt4(Mt4ClientConnectionParameters connectionParameters)
        {
            Client = new Client(connectionParameters.Server, connectionParameters.Login, connectionParameters.Password);
            Client.Connect();
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            while (stopwatch.ElapsedMilliseconds <= connectionParameters.ConnectionTimeout && !Client.isConnected)
            //while ( !Client.isConnected)
            {
                Thread.Sleep(5);
            }
           // Client.isConnected.Should().BeTrue();
           // Client.Disconnect();

            var acc = new ClientAccountInfo();
            Client.UserGet(ref acc);
            Console.WriteLine("Connected to {0} as {1:D}", acc.Server, acc.Login);
        }

        [When(@"I open a position:-")]
        public void WhenIOpenAPosition(Table table)
        {
            var trade = Client.OpenPosition("GBPUSD", TradeCommand.OP_BUY, 100,1.5);
            Console.WriteLine(trade.ToString());
           // trade.Tr.ExecutionTimeOf()
        }

        [When(@"I disconnect the client")]
        public void WhenIDisconnectTheClient()
        {
            Client.Disconnect();
        }

    }
}