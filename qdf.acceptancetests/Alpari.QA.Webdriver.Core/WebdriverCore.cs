using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Alpari.QA.Webdriver.Core.Constants;
using log4net;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    [DebuggerTypeProxy(typeof (WebDriverProxy))]
    public class WebdriverCore : IWebdriverCore
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (WebdriverCore));
        private IWebDriver _driver;
        private readonly FindElements _findElements;

        public WebdriverCore(IReadOnlyDictionary<string, string> options)
        {
            Options = options;
            _findElements = new FindElements(this, options);
        }

        public WebdriverCore()
        {
            Log.Debug("loading webdriverCore");
            Options = null;
            _findElements = new FindElements(this, Options);
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        internal IWebDriver Driver
        {
            get { return _driver ?? (_driver = WebDriverFactory.Create(Options)); }
        }

        /// <summary>
        ///     TODO:- replace with a POCO populated with a call to Linq to Xml?
        /// </summary>
        public IReadOnlyDictionary<string, string> Options { get; private set; }

        public void OpenPage(string url)
        {
            Driver.Navigate().GoToUrl(url);
        }

        /// <summary>
        ///     immediately return the element if it is there else return null
        /// </summary>
        /// <param name="by"></param>
        /// <returns></returns>
        public IWebElement FindElement(By by)
        {
            return _findElements.FindElement(by);
        }

        public IWebElement FindElement(By by, bool log)
        {
            return _findElements.FindElement(by, log);
        }

        public IWebElement WaitForElementToExist(By by)
        {
            return _findElements.WaitForElementToExist(by);
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
            Driver.Navigate().GoToUrl(Options[WebDriverConfig.BaseUrl]);
        }

        public bool Instantiated
        {
            get { return _driver != null; }
        }

        public string Url
        {
            get { return Driver.Url; }
        }

        public override string ToString()
        {
            var description = new StringBuilder();
            if (Options == null)
            {
                description.AppendFormat("description = {0},", base.ToString());
            }
            else
            {
                foreach (var option in Options)
                {
                    description.AppendFormat("{0} = {1},", option.Key, option.Value);
                }
            }

            description.AppendFormat(" started = {0}", Instantiated);

            return description.ToString();
        }

        /// <summary>
        ///     provided to show that viewing the collection of webdrivers in WebDriverManager can cause instantiaon of a driver
        ///     that wasn't meant to be launched yet
        ///     this internal class allows the options used to set up the driver to be viewed.
        ///     Anything else can be seen in the "Raw" node, which will force instantiation as a side effect
        /// </summary>
        internal class WebDriverProxy
        {
            // private IWebDriver _driver;

            public WebDriverProxy(IReadOnlyDictionary<string, string> options) // , IWebDriver driver)
            {
                Options = options;
                //  _driver = driver;
            }

            public IReadOnlyDictionary<string, string> Options { get; set; }

            //public bool Instantiated
            //{
            //    get { return _driver != null; }
            //}
        }
    }
}