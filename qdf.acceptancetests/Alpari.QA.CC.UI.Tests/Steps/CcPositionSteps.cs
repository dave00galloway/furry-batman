using System.Data;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
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
        public CcPositionSteps(IWebdriverCore webdriverCore, IPositionTablePageObject positionTablePageObject)
            : base(webdriverCore)
        {
            PositionTablePageObject = positionTablePageObject;
        }

        private IPositionTablePageObject PositionTablePageObject { get; set; }
        private HtmlTableData Positions { get; set; }
        public CcComparisonParameters CcComparisonParameters { get; set; }

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
            DataTable currentTable = null;
            DataTable newTable = null;
            var currentDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcCurrent);
            var currentPositionsPage = new PositionTablePageObject(currentDriver);
            currentDriver.OpenPage();

            var newDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcNew);
            var newPositionsPage = new PositionTablePageObject(newDriver);
            newDriver.OpenPage();

            //leaving driver creation outside of task until softkey sorted to make debugging easier

            var tasks = new Task[2]
            {
                Task.Factory.StartNew(()=>
                currentTable = currentPositionsPage.GetPositionDataAsDataTableBySymbols())
                ,
                Task.Factory.StartNew(()=>
                newTable = newPositionsPage.GetPositionDataAsDataTableBySymbols())
            };

            Task.WaitAll(tasks);
            var diffs = currentTable.Compare(newTable);
            diffs.CheckForDifferences();
            ScenarioContext.Current["diffs"] = diffs;
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