using System;
using System.Collections.Generic;
using Alpari.QA.Webdriver.Core.Constants;
using log4net;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Alpari.QA.Webdriver.Core
{
    /// <summary>
    ///     Provides methods for finding elements , waiting for elements, and syncing on elements
    /// </summary>
    public class ElementFinder : IElementFinder
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (ElementFinder));
        private IReadOnlyDictionary<string, string> _options;
        private IWebdriverCore _core;

        public IWebdriverCore Core
        {
            get { return _core; }
            set
            {
                _core = value;
                _options = _core.Options;
            }
        }

        /// <summary>
        ///     immediately return the element if it is there else return null
        /// </summary>
        /// <param name="by"></param>
        /// <returns></returns>
        public IWebElement FindElement(By by)
        {
            return FindWebElement(by, Core.Driver, true);
        }

        public IWebElement FindElement(By by, bool log)
        {
            return FindWebElement(by, Core.Driver, log);
        }

        public IWebElement WaitForElementToExist(By by)
        {
            var implicitWait = _options.GetImplicitWait();
            Log.InfoFormat("Waiting for {0} for {1} to exist", implicitWait, by);
            //TODO:- wait for Ajax?

            var wait = new WebDriverWait(new SystemClock(), Core.Driver, implicitWait,
                _options.GetPollingFrequency());
            //leaving this as an example of how to return a bool and an IWebElement in case needed
            //IWebElement findElement = null;
            //var found = wait.Until(driver =>
            //{
            //    findElement = FindWebElement(by, driver);
            //    return findElement != null;
            //});

            var element = wait.Until(driver => FindWebElement(by, driver));
            try
            {
                return element ?? FindWebElement(by, Core.Driver, true);
            }
            finally
            {
                if (element != null)
                    Log.InfoFormat("{0} found", by);
                else
                    Log.WarnFormat("{0} not found", by);
            }
        }


        private IWebElement FindWebElement(By by, IWebDriver webDriver, bool log = false)
        {
            if (_options == null)
            {
                return webDriver.FindElement(by);
            }
            webDriver.Manage().Timeouts().ImplicitlyWait(new TimeSpan(1));
            try
            {
                return webDriver.FindElement(by);
            }
            catch (Exception)
            {
                if (log)
                {
                    Log.DebugFormat("Element {0} was not found", by);
                }
                return null;
            }
            finally
            {
                webDriver.SetTimeout(_options, WebDriverConfig.ImplicitlyWait);
            }
        }
    }
}