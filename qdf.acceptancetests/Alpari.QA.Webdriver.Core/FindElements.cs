using System;
using System.Collections.Generic;
using Alpari.QA.Webdriver.Core.Constants;
using log4net;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;

namespace Alpari.QA.Webdriver.Core
{
    /// <summary>
    ///     TODO:- extract interface etc. etc.
    /// </summary>
    public class FindElements
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (FindElements));
        private readonly IReadOnlyDictionary<string, string> _options;
        private readonly WebdriverCore _webdriverCore;

        public FindElements(WebdriverCore webdriverCore, IReadOnlyDictionary<string, string> options)
        {
            _webdriverCore = webdriverCore;
            _options = options;
        }

        /// <summary>
        ///     immediately return the element if it is there else return null
        /// </summary>
        /// <param name="by"></param>
        /// <returns></returns>
        public IWebElement FindElement(By by)
        {
            return FindWebElement(by, _webdriverCore.Driver, true);
        }

        public IWebElement FindElement(By by, bool log)
        {
            return FindWebElement(by, _webdriverCore.Driver, log);
        }

        public IWebElement WaitForElementToExist(By by)
        {
            var implicitWait = _options.GetImplicitWait();
            Log.InfoFormat("Waiting for {0} for {1} to exist", implicitWait, by);
            //TODO:- wait for Ajax?

            var wait = new WebDriverWait(new SystemClock(), _webdriverCore.Driver, implicitWait,
                _options.GetPollingFrequency());
            IWebElement findElement = null;
            var found = wait.Until(driver =>
            {
                findElement = FindElement(by, false);
                return findElement != null;
            });
            try
            {
                return found ? findElement : FindElement(by, true);
            }
            finally
            {
                if (found)
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