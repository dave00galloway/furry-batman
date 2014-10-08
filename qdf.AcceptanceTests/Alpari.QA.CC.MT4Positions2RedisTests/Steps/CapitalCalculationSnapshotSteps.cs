using System;
using System.Collections.Generic;
using System.Windows.Forms.DataVisualization.Charting;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
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
            string resultName = String.Format("{0}_{1}_{2}", ccParameters.Server, ccParameters.Section,
                ccParameters.Book);
            IList<SnapshotComparison> result = CapitalCalculationDataContext.GetPositionSnapshots(ccParameters);
            result.EnumerableToCsv(
                String.Format("{0}{1}.{2}", ScenarioOutputDirectory, resultName, CsvParserExtensionMethods.csv), false);
            //new List<SnapshotComparison>
            //{
            //    new SnapshotComparison
            //    {
            //        Delta = (decimal) 0.5,
            //        Diff = (decimal) 0.5,
            //        Server1Name = "qa",
            //        Server1Volume = 100,
            //        Server2Name = "uat",
            //        Server2Volume = -100,
            //        SnapshotTimeToMinute = "2014/09/28 20:14:00"
            //    },
            //    new SnapshotComparison
            //    {
            //        Delta = (decimal) 0.4,
            //        Diff = (decimal) 0.4,
            //        Server1Name = "qa",
            //        Server1Volume = 110,
            //        Server2Name = "uat",
            //        Server2Volume = -110,
            //        SnapshotTimeToMinute = "2014/09/28 20:15:00"
            //    },
            //    new SnapshotComparison
            //    {
            //        Delta = (decimal) 0.3,
            //        Diff = (decimal) 0.5,
            //        Server1Name = "qa",
            //        Server1Volume = 200,
            //        Server2Name = "uat",
            //        Server2Volume = -210,
            //        SnapshotTimeToMinute = "2014/09/28 20:16:00"
            //    },
            //    new SnapshotComparison
            //    {
            //        Delta = (decimal) 0.3,
            //        Diff = (decimal) 0.5,
            //        Server1Name = "qa",
            //        Server1Volume = -200,
            //        Server2Name = "uat",
            //        Server2Volume = +210,
            //        SnapshotTimeToMinute = "2014/09/28 20:17:00"
            //    }
            //}.EnumerableToLineGraph(
            result.EnumerableToLineGraph(
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
                }, new EnumerableToGraphExtensions.ChartOptions
                {
                    FilePath = ScenarioOutputDirectory,
                    Name = resultName,
                    AxisXMajorGridInterval = 60
                });
        }

        [When(@"I get position data for these groups of snapshot parameters:-")]
        public void WhenIGetPositionDataForTheseGroupsOfSnapshotParameters(
            IEnumerable<CapitalCalculationSnapshotParameters> ccParameters)
        {
            foreach (CapitalCalculationSnapshotParameters ccParameter in ccParameters)
            {
                string resultName = String.Format("{0}_{1}_{2}_{3}", ccParameter.Server, ccParameter.Section,
                    ccParameter.Symbol,
                    ccParameter.Book);
                IList<SnapshotComparison> result = CapitalCalculationDataContext.GetPositionSnapshots(ccParameter);
                result.EnumerableToCsv(
                    String.Format("{0}{1}.{2}", ScenarioOutputDirectory, resultName, CsvParserExtensionMethods.csv),
                    false);
                result.EnumerableToLineGraph(
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
                    }, new EnumerableToGraphExtensions.ChartOptions
                    {
                        FilePath = ScenarioOutputDirectory,
                        Name = resultName,
                        AxisXMajorGridInterval = 60
                    });
            }
        }


        [When(@"I get cc redis and cc ars position data for these snapshot parameters:-")]
        public void WhenIGetCcRedisAndCcArsPositionDataForTheseSnapshotParameters(
            CapitalCalculationSnapshotParameters ccParameters)
        {
            string resultName = String.Format("{0}_{1}_{2}_{3}_{4}", ccParameters.Server1, ccParameters.Server2,
                ccParameters.Symbol, ccParameters.Section, ccParameters.Book);
            IList<SnapshotComparison> result =
                CapitalCalculationDataContext.GetRedisAndArsPositionSnapshots(ccParameters);
            result.EnumerableToCsv(
                String.Format("{0}{1}.{2}", ScenarioOutputDirectory, resultName, CsvParserExtensionMethods.csv), false);
            result.EnumerableToLineGraph(
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
                        SeriesName = ccParameters.Server1
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "Server2Volume",
                        SeriesName = ccParameters.Server2
                    }
                }, new EnumerableToGraphExtensions.ChartOptions
                {
                    FilePath = ScenarioOutputDirectory,
                    Name = resultName,
                    AxisXMajorGridInterval = 60
                });
        }

        [When(@"I get cc redis and cc ars position data for these sets of snapshot parameters:-")]
        public void WhenIGetCcRedisAndCcArsPositionDataForTheseSetsOfSnapshotParameters(
            IEnumerable<CapitalCalculationSnapshotParameters> ccParameters)
        {
            foreach (CapitalCalculationSnapshotParameters ccParameter in ccParameters)
            {
                string resultName = String.Format("{0}_{1}_{2}_{3}_{4}", ccParameter.Server1, ccParameter.Server2,
                    ccParameter.Symbol, ccParameter.Section, ccParameter.Book);
                IList<SnapshotComparison> result =
                    CapitalCalculationDataContext.GetRedisAndArsPositionSnapshots(ccParameter);
                result.EnumerableToCsv(
                    String.Format("{0}{1}.{2}", ScenarioOutputDirectory, resultName, CsvParserExtensionMethods.csv),
                    false);
                result.EnumerableToLineGraph(
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
                        SeriesName = ccParameter.Server1
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "Server2Volume",
                        SeriesName = ccParameter.Server2
                    }
                    }, new EnumerableToGraphExtensions.ChartOptions
                    {
                        FilePath = ScenarioOutputDirectory,
                        Name = resultName,
                        AxisXMajorGridInterval = 60
                    });
            }
        }
    }
}