using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    public class WebdriverCore
    {
        public void OpenPage(string url)
        {
            GetDriver().Navigate().GoToUrl(url);
        }

        /// <summary>
        /// ver lazy way of lazily initialising a webdriver
        /// </summary>
        /// <returns></returns>
        protected virtual IWebDriver GetDriver()
        {
            return Driver ?? (Driver = new ChromeDriver());
        }

        private IWebDriver Driver { get; set; }
    }
}
