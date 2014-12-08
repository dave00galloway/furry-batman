using Alpari.QA.Webdriver.Core.Elements;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IWebdriverCore
    {
        void OpenPage(string url);
        IWebElement FindElement(By by);
        void Quit();
        /// <summary>
        /// Opens the default page for the webdriver if set, otherwise does nothing
        /// </summary>
        void OpenPage();

        string Url { get; }


    }
}