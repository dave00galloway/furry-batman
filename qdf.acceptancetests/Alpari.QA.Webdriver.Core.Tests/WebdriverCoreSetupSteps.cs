using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.Webdriver.Core.Tests
{
    [Binding]
    public class WebdriverCoreSetupSteps
    {
        private IWebdriverCore Driver { get; set; }

        [When(@"I create a default webdriver")]
        public void WhenICreateADefaultWebdriver()
        {
            Driver = new WebdriverCore();
        }

        [When(@"I create a webdriver from ""(.*)""")]
        public void WhenICreateAWebdriverFrom(string webdriverConfigFile)
        {
            Driver = WebDriverCoreManager.Add(webdriverConfigFile);
        }

        [When(@"I navigate to the base url")]
        public void WhenINavigateToTheBaseUrl()
        {
            Driver.OpenPage();
        }

        [Then(@"the displayed url contains ""(.*)""")]
        public void ThenTheDisplayedUrlContains(string expectedUrl)
        {
            Driver.Url.Should().Contain(expectedUrl);
        }


        [Then(@"the default webdriver is not null")]
        public void ThenTheDefaultWebdriverIsNotNull()
        {
            Driver.Should().NotBeNull();
        }
    }
}