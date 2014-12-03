using Alpari.QA.Webdriver.Core;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcUiSteps : StepCentral
    {
        public CcUiSteps(WebdriverCore webdriverCore) : base(webdriverCore)
        {
        }

        [Given(@"I have opened the cc url ""(.*)""")]
        public void GivenIHaveOpenedTheCcUrl(string url)
        {
            WebdriverCore.OpenPage(url);
        }

        

        [Then(@"the position table is displayed")]
        public void ThenThePositionTableIsDisplayed()
        {
            ScenarioContext.Current.Pending();
        }

    }
}
