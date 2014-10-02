using System.Collections.Generic;
using System.Windows.Forms.DataVisualization.Charting;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class CapitalCalculationSnapshotSteps : StepCentral
    {
        public CapitalCalculationSnapshotSteps(CapitalCalculationDataContext capitalCalculationDataContext)
        {
            CapitalCalculationDataContext = capitalCalculationDataContext;
        }

        public CapitalCalculationDataContext CapitalCalculationDataContext { get; set; }

        [Given(@"I have a connection to CCDataContext")]
        public void GivenIHaveAConnectionToCcDataContext()
        {
            CapitalCalculationDataContext.Should().NotBeNull();
        }

        [When(@"I get position data for these snapshot parameters:-")]
        public void WhenIGetPositionDataForTheseSnapshotParameters(CapitalCalculationSnapshotParameters ccParameters)
        {
            //IList<SnapshotComparison> result = CapitalCalculationDataContext.GetPositionSnapshots(ccParameters);
            //result.EnumerableToCsv(
            //    string.Format("{0}{1}_{2}_{3}.{4}", ScenarioOutputDirectory, ccParameters.Server, ccParameters.Section,
            //        ccParameters.Book, CsvParserExtensionMethods.csv), false);
            new List<SnapshotComparison>
            {
                new SnapshotComparison
                {
                    Delta = (decimal) 0.5,
                    Diff = (decimal) 0.5,
                    Server1Name = "qa",
                    Server1Volume = 100,
                    Server2Name = "uat",
                    Server2Volume = -100,
                    SnapshotTimeToMinute = "2014/09/28 20:14:00"
                },
                new SnapshotComparison
                {
                    Delta = (decimal) 0.4,
                    Diff = (decimal) 0.4,
                    Server1Name = "qa",
                    Server1Volume = 110,
                    Server2Name = "uat",
                    Server2Volume = -110,
                    SnapshotTimeToMinute = "2014/09/28 20:15:00"
                },
                new SnapshotComparison
                {
                    Delta = (decimal) 0.3,
                    Diff = (decimal) 0.5,
                    Server1Name = "qa",
                    Server1Volume = 200,
                    Server2Name = "uat",
                    Server2Volume = -210,
                    SnapshotTimeToMinute = "2014/09/28 20:16:00"
                },
                new SnapshotComparison
                {
                    Delta = (decimal) 0.3,
                    Diff = (decimal) 0.5,
                    Server1Name = "qa",
                    Server1Volume = -200,
                    Server2Name = "uat",
                    Server2Volume = +210,
                    SnapshotTimeToMinute = "2014/09/28 20:17:00"
                }
            }.EnumerableToLineGraph(
                new EnumerableToGraphExtensions.DataSeriesParameters
                {
                    PropertyName = "SnapshotTimeToMinute",
                    ChartValueType = ChartValueType.DateTime
                },
                new List<EnumerableToGraphExtensions.DataSeriesParameters>
                {
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "Server1Volume",
                        SeriesName = "qa"
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "Server2Volume",
                        SeriesName = "uat"
                    }
                });
        }
    }
}