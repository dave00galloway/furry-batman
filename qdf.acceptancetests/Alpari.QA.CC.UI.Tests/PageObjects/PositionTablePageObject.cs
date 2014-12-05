using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
using OpenQA.Selenium;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public class PositionTablePageObject : PageBase, IPositionTablePageObject
    {
        private static readonly By PositionTableSelector = By.CssSelector("#position-table");

        public PositionTablePageObject(IWebdriverCore webdriverCore) : base(webdriverCore)
        {
            Displayed = PositionTableSelector;
        }

        public HtmlTableData GetPositionData()
        {
            return PositionTableSelector.GetTableData(WebdriverCore);
        }
    }
}