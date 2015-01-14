using System.Collections.Generic;
using System.Diagnostics;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IWebdriverCore: IElementFinder
    {
        IReadOnlyDictionary<string, string> Options { get; }
        string Url { get; }
        void OpenPage(string url);
        //IWebElement FindElement(By by);
        //IWebElement FindElement(By by,bool log);
        //IWebElement WaitForElementToExist(By by);
        void Quit();

        /// <summary>
        ///     Opens the default page for the webdriver if set, otherwise does nothing
        /// </summary>
        void OpenPage();

        bool Instantiated { get; }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        IWebDriver Driver { get; }
    }
}