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
        //TODO:- extract and use an interface for the business process
        private readonly CcPositionTableComparison _ccPositionTableComparison;

        public CcPositionComparisonSteps(CcPositionTableComparison ccPositionTableComparison)
        {
            _ccPositionTableComparison = ccPositionTableComparison;
        }

        private CcComparisonParameters CcComparisonParameters { get; set; }

        [Given(@"I have the following cc comparison parameters:-")]
        public void GivenIHaveTheFollowingCcComparisonParameters(CcComparisonParameters ccComparisonParameters)
        {
            CcComparisonParameters = ccComparisonParameters;
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
            var monitoringresults = _ccPositionTableComparison.MonitorPositions();
            monitoringresults.Export(new ExportParameters
            {
                ExportType = ExportTypes.DataTableToCsv,
                Path = ScenarioOutputDirectory,
                SeriesDateFormat = monitoringresults.DataTablePairComparisons.Keys.First().ToStringFormat
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