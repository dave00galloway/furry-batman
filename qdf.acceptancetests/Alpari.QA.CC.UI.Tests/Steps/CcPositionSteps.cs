using System.Linq;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
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

        [Then(@"the position table is displayed")]
        public void ThenThePositionTableIsDisplayed()
        {
            PositionTablePageObject.IsDisplayed().Should().Be(true);
        }

        [When(@"I get the positions")]
        public void WhenIGetThePositions()
        {
            Positions = PositionTablePageObject.GetPositionData();
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