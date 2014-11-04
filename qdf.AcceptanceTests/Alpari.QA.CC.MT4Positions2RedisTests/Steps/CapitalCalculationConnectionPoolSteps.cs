using System;
using System.Collections.Generic;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class CapitalCalculationConnectionPoolSteps : StepCentral
    {
        private IList<SnapshotComparison> _result;

        public CapitalCalculationConnectionPoolSteps(CapitalCalculationDataContextPool capitalCalculationDataContextPool)
        {
            CapitalCalculationDataContextPool = capitalCalculationDataContextPool;
        }

        private CapitalCalculationDataContextPool CapitalCalculationDataContextPool { get; set; }

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
                _result =
                    CapitalCalculationDataContextPool.GetRedisAndArsPositionSnapshots(ccParameter);
                CapitalCalculationSnapshotSteps.OutputComparisonResults(ccParameter, _result, resultName, ScenarioOutputDirectory, "SnapshotTimeToMinute",
                    "Server1Volume", ccParameter.Server1, "Server2Volume", ccParameter.Server2, 60);
            }
        }

        [When(@"I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-")]
        public void WhenICompareCcRedisAndCcArsClientPositionDataAcrossDbConnectionsForTheseSetsOfSnapshotParameters(CapitalCalculationSnapshotParameters snapshotParams)
        {
           // var arsData = CapitalCalculationDataContextPool.GetRedisAndArsClientPositions(snapshotParams);
            GetRedisPositionsSteps.GivenIHaveAConnectionToARedisRepositoryOnPortDb(
                    snapshotParams.Connection2, 6379, Convert.ToInt32(snapshotParams.Database2), "alpari-positions");
            GetRedisPositionsSteps.WhenIGetAllPositionsForServer(snapshotParams.Server2);
            var redisData = new ClientPositionDataTable().ConvertIEnumerableToDataTable(GetRedisPositionsSteps.Positions, "redis data", new[] { "Login", "Ticket" });

        }


        [Then(@"the count of cc connections is (.*)")]
        public void ThenTheCountOfCcConnectionsIs(int expectedConnectionCount)
        {
            CapitalCalculationDataContextPool.CapitalCalculationDataContexts.Should().HaveCount(expectedConnectionCount);
        }

        [Then(@"the snapshot comparison list contains (.*) results")]
        public void ThenTheSnapshotComparisonListContainsResults(int expResultCount)
        {
            _result.Should().HaveCount(expResultCount);
        }

    }
}