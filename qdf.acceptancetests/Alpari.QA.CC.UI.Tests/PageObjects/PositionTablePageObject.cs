using Alpari.QA.Webdriver.Core;
using OpenQA.Selenium;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public class PositionTablePageObject : PageBase
    {
        private static readonly By PositionTableSelector = By.CssSelector("#position-table");

        public PositionTablePageObject(IWebdriverCore webdriverCore)
        {
            WebdriverCore = webdriverCore;
            Displayed = PositionTableSelector;
        }
    }
}