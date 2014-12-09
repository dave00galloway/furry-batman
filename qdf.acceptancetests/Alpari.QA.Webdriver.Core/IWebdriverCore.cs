using System.Collections.Generic;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IWebdriverCore
    {
        IReadOnlyDictionary<string, string> Options { get; }
        string Url { get; }
        void OpenPage(string url);
        IWebElement FindElement(By by);
        void Quit();

        /// <summary>
        ///     Opens the default page for the webdriver if set, otherwise does nothing
        /// </summary>
        void OpenPage();
    }
}