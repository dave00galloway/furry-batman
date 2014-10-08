using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4CompositeApiSteps : StepCentral
    {
        public new static readonly string FullName = typeof (StepCentral).FullName;

        public Mt4CompositeApiSteps(IMt4CompositeApiManager mt4CompositeApiManager)
        {
            Mt4CompositeApiManager = mt4CompositeApiManager;
        }

        private IMt4CompositeApiManager Mt4CompositeApiManager { get; set; }

        [Given(@"I have the following connection parameters for the Mt4CompositeApi:-")]
        public void GivenIHaveTheFollowingConnectionParametersForTheMtCompositeApi(
            Mt4ApiConnectionParameters mt4ApiConnectionParameters)
        {
            Mt4CompositeApiManager.ManagerConnectionParameters = mt4ApiConnectionParameters;
        }

        [When(@"I bulk load trades into MT4:-")]
        public void WhenIBulkLoadTradesIntoMt4(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            Mt4CompositeApiManager.LoadTrades(mt4TradeBulkLoadParameters);
        }

        [When(@"I close all positions for login ""(.*)""")]
        public void WhenICloseAllPositionsForLogin(int login)
        {
            /*TODO:- currently the key for Mt4CompositeApiManager.dict is the login,
             * but the apis can store results for multiple logins, so manager wide versions 
             * of the api level methods could be implemented, 
             * in case the login in use changes during a sceanrio*/
            Mt4CompositeApiManager.GetMt4CompositeApi(login).ClosePositionsFor(login);
        }

        [When(@"I bulk close trades in MT4 for these logins:-")]
        public void WhenIBulkCloseTradesInMt4ForTheseLogins(IEnumerable<Mt4TradeBulkLoadParameters> mt4TradeBulkLoadParameters)
        {
            Mt4CompositeApiManager.BulkClosePositions(mt4TradeBulkLoadParameters);
        }


        [Then(@"the count of open trades for login ""(.*)"" will be (.*)")]
        public void ThenTheCountOfOpenTradesForLoginWillBe(string login, int expectedCount)
        {
            var result = Mt4CompositeApiManager.GetMt4CompositeApi(login).Mt4TradeLoadResultDictionary[login];
            result.PostLoadTradeList.Count.Should().Be(expectedCount);
        }


        [Then(@"the count of open trades for login ""(.*)"" will increase by (.*)")]
        public void ThenTheCountOfOpenTradesForLoginWillIncreaseBy(string login, int expectedIncrease)
        {
            var result = Mt4CompositeApiManager.GetMt4CompositeApi(login).Mt4TradeLoadResultDictionary[login];
            result.PostLoadTradeList.Count.Should().Be(result.PreLoadTradeList.Count + expectedIncrease);
        }
    }
}