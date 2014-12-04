using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IWebdriverCore
    {
        void OpenPage(string url);
        IWebElement FindElement(By by);
        void Quit();
    }
}