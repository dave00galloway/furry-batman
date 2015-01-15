using System.Linq;
using Alpari.QA.CC.UI.Tests.BusinessProcesses;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcPositionComparisonSteps : StepCentral
    {
        private readonly ICcPositionTableComparison _ccPositionTableComparison;

        public CcPositionComparisonSteps(ICcPositionTableComparison ccPositionTableComparison)
        {
            _ccPositionTableComparison = ccPositionTableComparison;
        }


        [Given(@"I have the following cc comparison parameters:-")]
        public void GivenIHaveTheFollowingCcComparisonParameters(CcComparisonParameters ccComparisonParameters)
        {
            _ccPositionTableComparison.CcComparisonParameters = ccComparisonParameters;
        }

        [When(@"I compare the current positions")]
        public void WhenICompareTheCurrentPositions()
        {
            ScenarioContext.Current["diffs"] = _ccPositionTableComparison.ComparePositionTables();
        }

        [When(@"I monitor the current positions")]
        public void WhenIMonitorTheCurrentPositions()
        {
            _ccPositionTableComparison.MonitorPositionsAndExport(new ExportParameters
            {
                ExportType = ExportTypes.DataTableToCsv,
                Path = ScenarioOutputDirectory
            });
        }

        [Then(@"the current positions should match exactly:-")]
        public void ThenTheCurrentPositionsShouldMatchExactly(ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];
            exportParameters.Path = ScenarioOutputDirectory;
            diffs.CheckForDifferences(exportParameters, true).Should().BeNullOrWhiteSpace();
        }
    }
}