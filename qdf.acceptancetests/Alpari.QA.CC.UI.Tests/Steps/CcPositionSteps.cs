using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcPositionSteps : StepCentral
    {
        public CcPositionSteps(IWebdriverCore webdriverCore, PositionTablePageObject positionTablePageObject)
            : base(webdriverCore)
        {
            PositionTablePageObject = positionTablePageObject;
        }

        private PositionTablePageObject PositionTablePageObject { get; set; }

        [Then(@"the position table is displayed")]
        public void ThenThePositionTableIsDisplayed()
        {
            PositionTablePageObject.IsDisplayed().Should().Be(true);
        }
    }
}