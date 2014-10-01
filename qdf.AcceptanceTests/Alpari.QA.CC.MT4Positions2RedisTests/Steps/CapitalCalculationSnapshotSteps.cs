using System.Collections.Generic;
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
            IList<SnapshotComparison> result = CapitalCalculationDataContext.GetPositionSnapshots(ccParameters);
            result.EnumerableToCsv(
                string.Format("{0}{1}_{2}_{3}.{4}", ScenarioOutputDirectory, ccParameters.Server, ccParameters.Section,
                    ccParameters.Book, CsvParserExtensionMethods.csv), false);
        }
    }
}