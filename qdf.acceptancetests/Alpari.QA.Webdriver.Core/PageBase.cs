using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public abstract class PageBase
    {
        protected By Displayed;
        protected IWebdriverCore WebdriverCore { get; set; }

        public bool IsDisplayed()
        {
            return WebdriverCore.FindElement(Displayed).Displayed;
        }
    }
}