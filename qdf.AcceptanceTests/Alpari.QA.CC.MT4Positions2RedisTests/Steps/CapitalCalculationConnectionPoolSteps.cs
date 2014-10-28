using System;
using System.Collections.Generic;
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

        [When(@"I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-")]
        public void WhenIGetCcRedisAndCcArsPositionDataAcrossDbConnectionsForTheseSetsOfSnapshotParameters(
            IEnumerable<CapitalCalculationSnapshotParameters> ccParameters)
        {
            foreach (var ccParameter in ccParameters)
            {
                string resultName = String.Format("{0}_{1}_{2}_{3}_{4}", ccParameter.Server1, ccParameter.Server2,
                    ccParameter.Symbol, ccParameter.Section, ccParameter.Book);
                IList<SnapshotComparison> result =
                    CapitalCalculationDataContextPool.GetRedisAndArsPositionSnapshots(ccParameter);                
            }
        }


        [Then(@"the count of cc connections is (.*)")]
        public void ThenTheCountOfCcConnectionsIs(int expectedConnectionCount)
        {
            CapitalCalculationDataContextPool.CapitalCalculationDataContexts.Should().HaveCount(expectedConnectionCount);
        }
    }
}