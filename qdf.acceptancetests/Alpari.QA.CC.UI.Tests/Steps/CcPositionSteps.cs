using System;
using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.BusinessProcesses;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcPositionSteps : StepCentral
    {
        private static readonly string[] ExcludeColumns = { "Client Total", "Coverage Total", "Net Total", "∑ Net", "∑ Client", "∑ Cov" };

        public CcPositionSteps(IWebdriverCore webdriverCore, IPositionTablePageObject positionTablePageObject)
            : base(webdriverCore)
        {
            PositionTablePageObject = positionTablePageObject;
        }

        private IPositionTablePageObject PositionTablePageObject { get; set; }
        private HtmlTableData Positions { get; set; }
        private CcComparisonParameters CcComparisonParameters { get; set; }

        [Then(@"the position table is displayed")]
        public void ThenThePositionTableIsDisplayed()
        {
            PositionTablePageObject.IsDisplayed().Should().Be(true);
        }

        /// <summary>
        ///     Basically a self test method to check we can get data. unlikely we want to use the Positions field at all
        /// </summary>
        [When(@"I get the positions")]
        public void WhenIGetThePositions()
        {
            Positions = PositionTablePageObject.GetPositionData();
        }

        /// <summary>
        ///     probably just a self test method, siunce any comparison will be between 2 position tables in differnet page objects
        /// </summary>
        [When(@"I compare the positions")]
        public void WhenICompareThePositions()
        {
            var currentTable = PositionTablePageObject.GetPositionDataAsDataTableBySymbols();
            var newTable = PositionTablePageObject.GetPositionDataAsDataTableBySymbols();
            var diffs = currentTable.Compare(newTable);
            diffs.CheckForDifferences();
        }

        [Given(@"I have the following cc comparison parameters:-")]
        public void GivenIHaveTheFollowingCcComparisonParameters(CcComparisonParameters ccComparisonParameters)
        {
            CcComparisonParameters = ccComparisonParameters;
        }

        [When(@"I compare the current positions")]
        public void WhenICompareTheCurrentPositions()
        {
            var comparisionProcess = new CcPositionTableComparison(CcComparisonParameters,ExcludeColumns);
            ScenarioContext.Current["diffs"] = comparisionProcess.ComparePositionTables();
        }

        [When(@"I monitor the current positions")]
        public void WhenIMonitorTheCurrentPositions()
        {
            //todo:- make this a class interface field initialised from constructor? might need to split this step class up as not all steps or even all scenarios that use this file will use all/most ofthe existing fields, including theWebdriver
            var comparisonProcess = new CcPositionTableComparison(CcComparisonParameters, ExcludeColumns);
            var monitoringresults = comparisonProcess.MonitorPositions();
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
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            exportParameters.Path = ScenarioOutputDirectory;
            diffs.CheckForDifferences(exportParameters, true).Should().BeNullOrWhiteSpace();
        }


        [Then(@"The count of servers is (.*)")]
        public void ThenTheCountOfServersIs(int serverCount)
        {
            Positions.First().Value.Keys.Should().HaveCount(serverCount);
        }

        [Then(@"the count of symbols is at least (.*)")]
        public void ThenTheCountOfSymbolsIsAtLeast(int minimumSymbols)
        {
            Positions.Count.Should().BeGreaterOrEqualTo(minimumSymbols);
        }
    }
}