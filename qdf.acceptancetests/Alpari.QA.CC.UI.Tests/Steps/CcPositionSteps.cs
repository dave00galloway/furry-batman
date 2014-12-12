using System.Linq;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
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
            //TODO:- parallelise into tasks
            var currentDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcCurrent);
            var newDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcNew);
            currentDriver.OpenPage();
            newDriver.OpenPage();
            IPositionTablePageObject currentPositionsPage = new PositionTablePageObject(currentDriver);
            IPositionTablePageObject newPositionsPage = new PositionTablePageObject(currentDriver);
            var currentTable = currentPositionsPage.GetPositionDataAsDataTableBySymbols();
            var newTable = newPositionsPage.GetPositionDataAsDataTableBySymbols();
            var diffs = currentTable.Compare(newTable);
            diffs.CheckForDifferences();
            
        }

        [Then(@"the current positions should match exactly:-")]
        public void ThenTheCurrentPositionsShouldMatchExactly(Table table)
        {
            ScenarioContext.Current.Pending();
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