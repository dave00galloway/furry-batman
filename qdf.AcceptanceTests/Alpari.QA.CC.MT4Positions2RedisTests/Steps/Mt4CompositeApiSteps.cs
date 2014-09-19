using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4CompositeApiSteps : StepCentral
    {
        public new static readonly string FullName = typeof (StepCentral).FullName;

        public Mt4CompositeApiSteps(IMt4CompositeApi mt4CompositeApi)
        {
            Mt4CompositeApi = mt4CompositeApi;
        }

        private IMt4CompositeApi Mt4CompositeApi { get; set; }

        [Given(@"I have the following connection parameters for the Mt4CompositeApi:-")]
        public void GivenIHaveTheFollowingConnectionParametersForTheMtCompositeApi(
            Mt4ApiConnectionParameters mt4ApiConnectionParameters)
        {
            Mt4CompositeApi.ManagerConnectionParameters = mt4ApiConnectionParameters;
        }

        [When(@"I bulk load trades into MT4:-")]
        public void WhenIBulkLoadTradesIntoMt4(Mt4TradeBulkLoadParameters mt4TradeBulkLoadParameters)
        {
            Mt4CompositeApi.StoreTradeResult(mt4TradeBulkLoadParameters,
                Mt4CompositeApi.LoadTrades(mt4TradeBulkLoadParameters));
        }

        [When(@"I close all positions for login ""(.*)""")]
        public void WhenICloseAllPositionsForLogin(int p0)
        {
            Mt4CompositeApi.ClosePositionsFor(p0);
        }

        [Then(@"the count of open trades for login ""(.*)"" will be (.*)")]
        public void ThenTheCountOfOpenTradesForLoginWillBe(string login, int expectedCount)
        {
            var result = Mt4CompositeApi.Mt4TradeLoadResultDictionary[login];
            result.PostLoadTradeList.Count.Should().Be(expectedCount);
        }


        [Then(@"the count of open trades for login ""(.*)"" will increase by (.*)")]
        public void ThenTheCountOfOpenTradesForLoginWillIncreaseBy(string login, int expectedIncrease)
        {
            var result = Mt4CompositeApi.Mt4TradeLoadResultDictionary[login];
            result.PostLoadTradeList.Count.Should().Be(result.PreLoadTradeList.Count + expectedIncrease);
        }
    }
}