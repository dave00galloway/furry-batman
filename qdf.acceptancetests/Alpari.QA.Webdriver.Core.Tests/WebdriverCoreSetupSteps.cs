using System.Threading.Tasks;
using Alpari.QA.Webdriver.Core.Constants;
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

        [When(@"I create a webdriver named ""(.*)"" from ""(.*)""")]
        public void WhenICreateAWebdriverNamedFrom(string name, string webdriverConfigFile)
        {
            WebDriverCoreManager.Add(name, webdriverConfigFile);
        }

        [When(@"I navigate to the base url")]
        public void WhenINavigateToTheBaseUrl()
        {
            Driver.OpenPage();
            //WebDriverCoreManager.Drivers(Driver.Options[WebDriverConfig.Name].ToString()).OpenPage();
        }

        [When(@"I start these webdrivers ""(.*)""")]
        public void WhenIStartTheseWebdrivers(string driversToStart)
        {
            Parallel.ForEach(driversToStart.Split(','), driver => WebDriverCoreManager.Drivers(driver).OpenPage());
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

        [Then(@"the webdriver manager contains (.*) drivers with the name ""(.*)""")]
        public void ThenTheWebdriverManagerContainsDriversWithTheName(int count, string name)
        {
            WebDriverCoreManager.Drivers(WebDriverConfig.Name, name).Should().HaveCount(count);
        }

        [AfterScenario]
        public void AfterScenario()
        {
            if (Driver != null)
            {
                Driver.Quit();
            }
            WebDriverCoreManager.RemoveAll();
        }
    }
}