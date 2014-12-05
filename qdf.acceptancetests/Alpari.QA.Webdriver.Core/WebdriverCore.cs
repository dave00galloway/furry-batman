using System.Collections.Generic;
using System.Linq;
using System.Net;
using Alpari.QA.Webdriver.Core.Constants;
using Alpari.QA.Webdriver.Core.Elements;
using HtmlAgilityPack;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    //TODO:- decide if the Webdriver core will hold multipe selenium instances, or have a container for Cores
    public class WebdriverCore : IWebdriverCore
    {
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
            //TODO:- detect if running as a container and quit all instances
            Driver.Quit();
        }

        /// <summary>
        ///     very lazy way of lazily initialising a webdriver
        /// </summary>
        /// <returns></returns>
        protected virtual IWebDriver GetDriver()
        {
            return Driver ?? (Driver = new ChromeDriver());
        }
    }
}