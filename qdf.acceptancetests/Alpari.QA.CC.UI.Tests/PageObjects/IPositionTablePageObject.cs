using System.Data;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public interface IPositionTablePageObject : IPageBase
    {
        HtmlTableData GetPositionData();
        DataTable GetPositionDataAsDataTableBySymbols();
    }
}