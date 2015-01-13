using System.Data;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Constants;
using Alpari.QA.Webdriver.Core.Elements;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public class PositionTablePageObject : PageBase, IPositionTablePageObject
    {
        private readonly IPositionTableBys _positionTableBys;

        public PositionTablePageObject(IWebdriverCore webdriverCore, IPositionTableBys positionTableBys)
            : base(webdriverCore)
        {
            _positionTableBys = positionTableBys;
            Displayed = PositionTableBys.PositionTableSelector;
        }

        public IPositionTableBys PositionTableBys
        {
            get { return _positionTableBys; }
        }

        public void ConfigurePositionTable(CcComparisonParameters comparisonParameters)
        {
            //Set the book and server selections. Always select the book, even if its currently displayed, and select the servers according to passed params
        }

        public HtmlTableData GetPositionData()
        {
            return PositionTableBys.PositionTableSelector.GetTableData(WebdriverCore);
        }

        public DataTable GetPositionDataAsDataTableBySymbols()
        {
            return
                PositionTableBys.PositionTableSelector.GetTableData(WebdriverCore)
                    .ConvertHtmlTableDataToDataTable("Symbol", WebdriverCore.Options[WebDriverConfig.Name]);
        }
    }
}