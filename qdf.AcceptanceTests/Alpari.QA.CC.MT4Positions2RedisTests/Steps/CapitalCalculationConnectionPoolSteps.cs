using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class CapitalCalculationConnectionPoolSteps
    {
        public CapitalCalculationConnectionPoolSteps(CapitalCalculationDataContextPool capitalCalculationDataContextPool)
        {
            CapitalCalculationDataContextPool = capitalCalculationDataContextPool;
        }

        public CapitalCalculationDataContextPool CapitalCalculationDataContextPool { get; set; }

        [Given(@"I have the following connections to cc:-")]
        public void GivenIHaveTheFollowingConnectionsToCc(Table table)
        {
            CapitalCalculationDataContextPool.CapitalCalculationDataContextPoolParams =
                table.CreateInstance<CapitalCalculationDataContextPoolParams>();
        }

        [Then(@"the count of cc connections is (.*)")]
        public void ThenTheCountOfCcConnectionsIs(int expectedConnectionCount)
        {
            CapitalCalculationDataContextPool.CapitalCalculationDataContexts.Should().HaveCount(expectedConnectionCount);
        }
    }
}