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
    }
}