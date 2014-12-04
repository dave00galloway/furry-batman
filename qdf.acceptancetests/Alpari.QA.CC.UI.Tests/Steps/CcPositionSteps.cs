using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core;
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

        [Then(@"the position table is displayed")]
        public void ThenThePositionTableIsDisplayed()
        {
            PositionTablePageObject.IsDisplayed().Should().Be(true);
        }

        [When(@"I get the positions")]
        public void WhenIGetThePositions()
        {
            var positions = PositionTablePageObject.GetPositionData();
        }

        [Then(@"The count of servers is (.*)")]
        public void ThenTheCountOfServersIs(int serverCount)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the count of symbols is at least (.*)")]
        public void ThenTheCountOfSymbolsIsAtLeast(int minimumSymbols)
        {
            ScenarioContext.Current.Pending();
        }

    }
}