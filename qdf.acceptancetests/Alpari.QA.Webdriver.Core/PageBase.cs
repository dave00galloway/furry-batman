using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public interface IPageBase
    {
        bool IsDisplayed();
    }

    public abstract class PageBase : IPageBase
    {
        protected By Displayed;
        protected IWebdriverCore WebdriverCore { get; set; }

        protected PageBase(IWebdriverCore webdriverCore)
        {
            WebdriverCore = webdriverCore;
        }

        public bool IsDisplayed()
        {
            return WebdriverCore.FindElement(Displayed).Displayed;
        }

    }
}