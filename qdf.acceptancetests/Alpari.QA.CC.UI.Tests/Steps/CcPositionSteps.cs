using System.Linq;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core.Elements;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcPositionSteps : StepCentral
    {
        public CcPositionSteps(IPositionTablePageObject positionTablePageObject)
        {
            //Core = webdriverCore;
            PositionTablePageObject = positionTablePageObject;
        }

        //private IWebdriverCore Core { get; set; }
        private IPositionTablePageObject PositionTablePageObject { get; set; }
        private HtmlTableData Positions { get; set; }


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