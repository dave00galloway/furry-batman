using System;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IElementFinder
    {
        /// <summary>
        ///     immediately return the element if it is there else return null
        /// </summary>
        /// <param name="by"></param>
        /// <returns></returns>
        IWebElement FindElement(By by);

        IWebElement FindElement(By by, bool log);
        IWebElement WaitForElementToExist(By by);
        string WaitForElementAttributeToHaveProperty(By by, string attributeName, string attributeValue);
        string WaitForElementAttributeToHaveProperty(By by, string attributeName, string attributeValue, TimeSpan wait);
        IWebdriverCore Core { get; set; }
    }
}