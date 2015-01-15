using System;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core.Elements
{
    public static class ClickableElementExtensions
    {
        public static void Click(this By by, IWebdriverCore webdriverCore)
        {
            //todo:- sync on visible/active/enabled etc.
            try
            {
                webdriverCore.FindElement(by).Click();
            }
            catch (Exception)
            {
                webdriverCore.FindElement(by, true).Click();
            }
        }

        public static void Click(this By by, IWebdriverCore webdriverCore, bool waitForDisplayed = false,
            bool waitForEnabled = false)
        {
            var wait = webdriverCore.SetDefaultImplicitWait();
            webdriverCore.WaitForElementToExist(by);
            if (waitForDisplayed) wait.Until(driver => webdriverCore.FindElement(by).Displayed);
            if (waitForEnabled) wait.Until(driver => webdriverCore.FindElement(by).Enabled);
            webdriverCore.WaitForElementToExist(by);
            wait.IgnoreExceptionTypes(typeof(InvalidOperationException), // this saves having to come up with some complex method of determining if a blocking panel e.g. blockUI blockOverlay has appeared, disappeared, ahs the correct/no style
                typeof(StaleElementReferenceException));  // this one shouldn't be necessary since we don't click unless we just found an element, and we never store the Webeleemnt, only the By
            wait.Until(driver =>
            {
                by.Click(webdriverCore);
                return true; // if we got here without throwing an exception then we can return any non-null value to satisfy the 'Until' Predicate
            }
                
                );
        }
    }
}