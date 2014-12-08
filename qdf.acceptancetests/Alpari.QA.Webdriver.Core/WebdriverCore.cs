using System;
using System.Collections.Generic;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    public class WebdriverCore : IWebdriverCore
    {
        /// <summary>
        ///     TODO:- replace with a POCO populated with a call to Linq to Xml
        /// </summary>
        public readonly IReadOnlyDictionary<string, object> Options;

        public WebdriverCore(IReadOnlyDictionary<string, object> options)
        {
            Options = options;
        }

        public WebdriverCore()
        {
            Options = null;
        }

        private IWebDriver Driver { get; set; }

        public void OpenPage(string url)
        {
            GetDriver().Navigate().GoToUrl(url);
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
            GetDriver().Navigate().GoToUrl(Options["BaseUrl"].ToString());
        }

        public string Url
        {
            get { return Driver.Url; }
        }

        /// <summary>
        ///     very lazy way of lazily initialising a webdriver
        /// </summary>
        /// <returns></returns>
        protected virtual IWebDriver GetDriver()
        {
            return Driver ?? (SetupWebDriver());
        }

        protected virtual IWebDriver SetupWebDriver()
        {
            if (Options == null)
            {
                return Driver = new ChromeDriver();
            }
            IWebDriver webDriver;
            switch (Options["Driver"].ToString())
            {
                case "ChromeDriver":
                    webDriver = SetupChromeDriver();
                    break;

                default:
                    webDriver = new ChromeDriver();
                    break;
            }

            Driver = webDriver;
            return Driver;
        }

        private ChromeDriver SetupChromeDriver()
        {
            ChromeDriver webDriver;
            //if we need to configure any settings using the chrome options, then set up the chrome options, otherwise don't bother
            //var co = new ChromeOptions();
            //co.
            webDriver = new ChromeDriver();
            webDriver.Manage()
                .Timeouts()
                .ImplicitlyWait(new TimeSpan(TimeSpan.TicksPerSecond*Convert.ToInt16(Options["ImplicitlyWait"])));
            return webDriver;
        }
    }
}