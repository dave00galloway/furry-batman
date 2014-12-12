using System.Collections.Generic;
using System.Diagnostics;
using Alpari.QA.Webdriver.Core.Constants;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    [DebuggerTypeProxy(typeof(WebDriverProxy))]
    public class WebdriverCore : IWebdriverCore
    {
        /// <summary>
        ///     TODO:- replace with a POCO populated with a call to Linq to Xml?
        /// </summary>
        public IReadOnlyDictionary<string, string> Options { get; private set; }

        private IWebDriver _driver;

        public WebdriverCore(IReadOnlyDictionary<string, string> options)
        {
            Options = options;
        }

        public WebdriverCore(IReadOnlyDictionary<string, string> options, IWebDriver driver)
        {
            Options = options;
            _driver = driver;
        }

        public WebdriverCore()
        {
            Options = null;
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
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
            if (_driver != null)
            {
                Driver.Quit();
            }
        }

        public void OpenPage()
        {
            Driver.Navigate().GoToUrl(Options[WebDriverConfig.BaseUrl].ToString());
        }

        public bool Instantiated
        {
            get { return _driver != null; }
        }

        public string Url
        {
            get { return Driver.Url; }
        }

        public class WebDriverProxy
        {
            private IWebDriver _driver;
            public IReadOnlyDictionary<string, string> Options { get; set; }
            public WebDriverProxy(IReadOnlyDictionary<string, string> options , IWebDriver driver)
            {
                Options = options;
                _driver = driver;
            }

            public bool Instantiated
            {
                get { return _driver != null; }
            }
        }
    }
}