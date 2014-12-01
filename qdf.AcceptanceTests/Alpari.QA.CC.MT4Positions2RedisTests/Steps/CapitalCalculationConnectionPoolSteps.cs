using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
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
            foreach (CapitalCalculationSnapshotParameters ccParameter in ccParameters)
            {
                string resultName = String.Format("{0}_{1}_{2}_{3}_{4}", ccParameter.Server1, ccParameter.Server2,
                    ccParameter.Symbol, ccParameter.Section, ccParameter.Book);
                _result =
                    CapitalCalculationDataContextPool.GetRedisAndArsPositionSnapshots(ccParameter);
                CapitalCalculationSnapshotSteps.OutputComparisonResults(ccParameter, _result, resultName,
                    ScenarioOutputDirectory, "SnapshotTimeToMinute",
                    "Server1Volume", ccParameter.Server1, "Server2Volume", ccParameter.Server2, 60);
            }
        }

        /// <summary>
        /// Use where the MT server name is the same, but the database is different. this could be across differnt connections
        /// </summary>
        /// <param name="ccParameters"></param>
        [When(@"I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-")]
        public void WhenIGetCcRedisAndCcArsPositionDataAcrossDbConnectionsAndDatabasesForTheseSetsOfSnapshotParameters(
            IEnumerable<CapitalCalculationSnapshotParameters> ccParameters)
        {
            foreach (CapitalCalculationSnapshotParameters ccParameter in ccParameters)
            {
                string resultName = String.Format("{0}_{1}_{2}_{3}_{4}", ccParameter.Server1, ccParameter.Server2,
                    ccParameter.Symbol, ccParameter.Section, ccParameter.Book);
                _result =
                    CapitalCalculationDataContextPool.GetRedisAndArsPositionSnapshots(ccParameter);
                foreach (var comparison in _result)
                {
                    comparison.Server1Name = ccParameter.Database1;
                    comparison.Server2Name = ccParameter.Database2;
                }

                CapitalCalculationSnapshotSteps.OutputComparisonResults(ccParameter, _result, resultName,
                    ScenarioOutputDirectory, "SnapshotTimeToMinute",
                    "Server1Volume", ccParameter.Database1, "Server2Volume", ccParameter.Database2, 60);
            }
        }

        [When(
            @"I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-"
            )]
        public void WhenICompareCcRedisAndCcArsClientPositionDataAcrossDbConnectionsForTheseSetsOfSnapshotParameters(
            CapitalCalculationSnapshotParameters snapshotParams)
        {
            ClientPositionDataTable arsData =
                CapitalCalculationDataContextPool.GetRedisAndArsClientPositions(snapshotParams);
            GetRedisPositionsSteps.GivenIHaveAConnectionToARedisRepositoryOnPortDb(
                snapshotParams.Connection2, 6379, Convert.ToInt32(snapshotParams.Database2), "alpari-positions");
            GetRedisPositionsSteps.WhenIGetAllPositionsForServer(snapshotParams.Server2);
            ClientPositionDataTable redisData =
                new ClientPositionDataTable().ConvertIEnumerableToDataTable(GetRedisPositionsSteps.Positions,
                    "redis data", new[] {"Login", "Ticket"});

            DataTableComparison diffs =
                redisData.Compare(arsData, new[] {"ServerName", "ServerId", "SectionId"}, null, false, true);
            ScenarioContext.Current["diffs"] = diffs;
            //TODO:- create after hook for this:-
            arsData.Rows.Cast<ClientPositionDataRow>()
                .OrderBy(p => p.Login)
                .ThenBy(p => p.Ticket)
                .EnumerableToCsv(
                    String.Format("{0}{1}.{2}", ScenarioOutputDirectory, "Ars"+snapshotParams.Server1,
                        CsvParserExtensionMethods.csv), true, true, true, true);
            redisData.Rows.Cast<ClientPositionDataRow>()
                .OrderBy(p => p.Login)
                .ThenBy(p => p.Ticket)
                .EnumerableToCsv(
                    String.Format("{0}{1}.{2}", ScenarioOutputDirectory, "Redis" + snapshotParams.Server2,
                        CsvParserExtensionMethods.csv), true, true, true, true);
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