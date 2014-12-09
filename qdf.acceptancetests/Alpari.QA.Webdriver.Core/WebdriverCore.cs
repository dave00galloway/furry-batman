using System.Collections.Generic;
using Alpari.QA.Webdriver.Core.Constants;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public class WebdriverCore : IWebdriverCore
    {
        /// <summary>
        ///     TODO:- replace with a POCO populated with a call to Linq to Xml?
        /// </summary>
        public readonly IReadOnlyDictionary<string, object> Options;

        private IWebDriver _driver;

        public WebdriverCore(IReadOnlyDictionary<string, object> options)
        {
            Options = options;
        }

        public WebdriverCore()
        {
            Options = null;
        }

        private IWebDriver Driver
        {
            get { return _driver ?? (_driver = WebDriverFactory.Create(Options)); }
        }

        public void OpenPage(string url)
        {
            Driver.Navigate().GoToUrl(url);
        }

        public IWebElement FindElement(By by)
        {
            //TODO:- add sync, logging etc...
            return Driver.FindElement(by);
        }

        public void Quit()
        {
            if (Driver != null)
            {
                Driver.Quit();
            }
        }

        public void OpenPage()
        {
            Driver.Navigate().GoToUrl(Options[WebDriverConfig.BaseUrl].ToString());
        }

        public string Url
        {
            get { return Driver.Url; }
        }
    }
}