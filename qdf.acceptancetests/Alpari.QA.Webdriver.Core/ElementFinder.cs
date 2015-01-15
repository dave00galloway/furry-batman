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
        private IWebdriverCore _core;
        private IReadOnlyDictionary<string, string> _options;


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

            var wait = SetupImplicitWait(implicitWait);
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

        /// <summary>
        ///     Most simple method of synicng on a property. Could add overloads to allow for contains, case sensitiivty etc. could
        ///     also add a fluent ovrload to allow multiple conditions to be chained together?
        ///     Or even an overload which delegate the entire determination of conditions to the calling method
        /// </summary>
        /// <param name="by"></param>
        /// <param name="attributeName"></param>
        /// <param name="attributeValue"></param>
        /// <returns></returns>
        public string WaitForElementAttributeToHaveProperty(By by, string attributeName, string attributeValue)
        {
            return WaitForElementAttributeToHavePropertyValue(by, attributeName, attributeValue,
                _options.GetImplicitWait());
        }

        public string WaitForElementAttributeToHaveProperty(By by, string attributeName, string attributeValue,
            TimeSpan waitTimeSpan)
        {
            return waitTimeSpan == default(TimeSpan)
                ? WaitForElementAttributeToHaveProperty(by, attributeName, attributeValue)
                : WaitForElementAttributeToHavePropertyValue(by, attributeName, attributeValue, waitTimeSpan);
        }

        private string WaitForElementAttributeToHavePropertyValue(By by, string attributeName, string attributeValue,
            TimeSpan waitTimeSpan)
        {
            var message = String.Format("Waiting for {0} for {1} to have property '{2}' value '{3}' ", waitTimeSpan, by,
                attributeName, attributeValue);
            Log.InfoFormat(message);
            //TODO:- wait for Ajax?

            var wait = SetupImplicitWait(waitTimeSpan);
            string value = null;
            try
            {
                wait.Until(driver =>
                {
                    value = FindWebElement(by, driver).GetAttribute(attributeName);
                    return value.Equals(attributeValue, StringComparison.InvariantCulture);
                });
            }
                
            catch (Exception e)
            {
                Log.Warn("Exception while " + message ,e);
            }
            finally
            {
                Log.DebugFormat("Found {0} while {1}",value,message);
            }
            return value;
        }

        private WebDriverWait SetupImplicitWait(TimeSpan implicitWait)
        {
            return new WebDriverWait(new SystemClock(), Core.Driver, implicitWait,
                _options.GetPollingFrequency());
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