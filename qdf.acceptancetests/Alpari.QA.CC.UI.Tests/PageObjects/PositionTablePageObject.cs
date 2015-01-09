﻿using System.Data;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Elements;
using OpenQA.Selenium;

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

        public HtmlTableData GetPositionData()
        {
            return PositionTableBys.PositionTableSelector.GetTableData(WebdriverCore);
        }

        public DataTable GetPositionDataAsDataTableBySymbols()
        {
            return
                PositionTableBys.PositionTableSelector.GetTableData(WebdriverCore)
                    .ConvertHtmlTableDataToDataTable("Symbol", WebdriverCore.Options["Name"]);
        }
    }
}