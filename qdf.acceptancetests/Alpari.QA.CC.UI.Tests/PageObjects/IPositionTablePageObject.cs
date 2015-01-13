using System.Data;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public interface IPositionTablePageObject : IPageBase
    {
        HtmlTableData GetPositionData();
        DataTable GetPositionDataAsDataTableBySymbols();
        IPositionTableBys PositionTableBys { get; }
        void ConfigurePositionTable(CcComparisonParameters comparisonParameters);
    }
}