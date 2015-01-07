using Alpari.QA.Webdriver.Core;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcUiSteps : StepCentral
    {
        private readonly IWebdriverCore _webdriverCore;

        public CcUiSteps(IWebdriverCore webdriverCore)
        {
            _webdriverCore = webdriverCore;
        }

        [Given(@"I have opened the cc url ""(.*)""")]
        public void GivenIHaveOpenedTheCcUrl(string url)
        {
            _webdriverCore.OpenPage(url);
        }

    }
}
