using System.Collections.Generic;
using System.Diagnostics;
using Alpari.QA.Webdriver.Core.Constants;
using log4net;
using log4net.Config;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    [DebuggerTypeProxy(typeof (WebDriverProxy))]
    public class WebdriverCore : IWebdriverCore
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(WebdriverCore));
        private IWebDriver _driver;

        public WebdriverCore(IReadOnlyDictionary<string, string> options)
        {
            Options = options;
        }

        //public WebdriverCore(IReadOnlyDictionary<string, string> options, IWebDriver driver)
        //{
        //    Options = options;
        //    _driver = driver;
        //}

        public WebdriverCore()
        {
            Log.Debug("loading webdriverCore");
            Options = null;
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private IWebDriver Driver
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