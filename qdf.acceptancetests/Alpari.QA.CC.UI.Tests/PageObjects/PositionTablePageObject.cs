using System.Data;
using System.Text;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
using OpenQA.Selenium;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public class PositionTablePageObject : PageBase, IPositionTablePageObject
    {
        private readonly IPositionTableBys _positionTableBys;

        public PositionTablePageObject(IWebdriverCore webdriverCore, IPositionTableBys positionTableBys) : base(webdriverCore)
        {
            _positionTableBys = positionTableBys;
            Displayed = _positionTableBys.PositionTableSelector;
        }

        public HtmlTableData GetPositionData()
        {
            return _positionTableBys.PositionTableSelector.GetTableData(WebdriverCore);
        }

        public DataTable GetPositionDataAsDataTableBySymbols()
        {
            return _positionTableBys.PositionTableSelector.GetTableData(WebdriverCore).ConvertHtmlTableDataToDataTable("Symbol", WebdriverCore.Options["Name"]);
        }
    }

    public static class PositionTablePageObjectFactory
    {
        public static IPositionTablePageObject Create(this IWebdriverCore webdriverCore, string version)
        {
            IPositionTableBys positionTableBys = null;
            var positionTableBy = new PositionTableBy();

            switch (version)
            {
                case "4.5":
                    
                    positionTableBys = new PositionTableBy4_5(positionTableBy);
                    break;

                case "4.6":
                    positionTableBys = new PositionTableBy4_6(positionTableBy);
                    break;
            }

            return new PositionTablePageObject(webdriverCore, positionTableBys);
        }
    }

    public interface IPositionTableBys
    {
        By PositionTableSelector { get; set; }
        By BBookSelector { get; }
        PositionTableBy PositionTableBys { get; set; }
    }
    

    public static class PositionTableByInvariants
    {
        public static readonly By PositionTableSelector = By.CssSelector("#position-table");
    }

    public class PositionTableBy4_5 : IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#bookType-option-B");
        public By PositionTableSelector { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public PositionTableBy4_5(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }

        public PositionTableBy PositionTableBys { get; set; }
    }

    public class PositionTableBy4_6 :  IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#viewType-option-B");
        public By PositionTableSelector { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public PositionTableBy PositionTableBys { get; set; }

        public PositionTableBy4_6(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }
    }

    public class PositionTableBy : IPositionTableBys
    {
        public By PositionTableSelector { get; set; }
        public By BBookSelector { get; private set; }
        public PositionTableBy PositionTableBys { get;  set; }

        public void SetCommonBys(IPositionTableBys positionTableBy)
        {
            PositionTableSelector = PositionTableByInvariants.PositionTableSelector;
            PositionTableBys = this;
            positionTableBy.PositionTableBys = this;
            positionTableBy.PositionTableSelector = PositionTableSelector;
            BBookSelector = null;
        }
    }
}