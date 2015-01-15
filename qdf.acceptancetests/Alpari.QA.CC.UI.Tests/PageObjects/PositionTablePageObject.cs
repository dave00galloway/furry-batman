using System;
using System.Data;
using System.Linq;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QA.Webdriver.Core.Constants;
using Alpari.QA.Webdriver.Core.Elements;
using log4net;
using OpenQA.Selenium;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    public class PositionTablePageObject : PageBase, IPositionTablePageObject
    {
        private const string BtnBtnDefaultActive = "btn btn-default active";
        private static readonly ILog Log = LogManager.GetLogger(typeof (PositionTablePageObject));
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
            WebdriverCore.WaitForElementToExist(PositionTableBys.PositionTableSelector);
            if (CheckCcComparisonParameters(comparisonParameters, ShortTimeout()).Set) return;
            SetPositionConfig(comparisonParameters);
            if (CheckCcComparisonParameters(comparisonParameters).Set) return;
            throw new Exception("one or more position settings could not be set. check log for details");
        }

        public CcComparisonParameters CheckComparisonParameters(CcComparisonParameters comparisonParameters)
        {
            return CheckCcComparisonParameters(comparisonParameters);
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

        /// <summary>
        ///     ToDo:- move to TimeoutExtensions
        /// </summary>
        /// <returns></returns>
        private TimeSpan ShortTimeout()
        {
            return TimeSpan.FromTicks((WebdriverCore.Options.GetPollingFrequency()).Ticks*2);
        }

        #region private methods - could this be simplified if the Wait... methods took delegates defined in the page object?

        private CcComparisonParameters CheckCcComparisonParameters(CcComparisonParameters comparisonParameters,
            TimeSpan wait = default(TimeSpan))
        {
            var actual = new CcComparisonParameters();

            WebdriverCore.WaitForElementToExist(PositionTableBys.PositionTableSelector);

            var bookSelected = BookSelected(comparisonParameters, BtnBtnDefaultActive, actual, wait);
            var tableData = GetPositionData();


            var message = String.Format("positons on page {0} book {1} as {2} ",
                WebdriverCore.Options[WebDriverConfig.BaseUrl], comparisonParameters.Book,
                WebdriverCore.Options[WebDriverConfig.Name]);
            if (bookSelected &&
                comparisonParameters.MinimumServers < tableData.First().Value.Keys.Count &&
                comparisonParameters.MinimumSymbols < tableData.Count)
            {
                Log.InfoFormat("{0} were as expected", message);
                actual.Set = true;
            }
            else
            {
                Log.WarnFormat("{0} were not as expected", message);
                Log.WarnFormat("bookSelected = {0}", bookSelected);
                Log.WarnFormat("server count = {0}", tableData.First().Value.Keys.Count);
                Log.WarnFormat("symbol count = {0}", tableData.Count);
                actual.Set = false;
            }

            return actual;
        }

        private void SetPositionConfig(CcComparisonParameters comparisonParameters)
        {
            SetBook(comparisonParameters);
            SetServers(comparisonParameters);
        }

        private void SetServers(CcComparisonParameters comparisonParameters)
        {
            //not bothering with a pre check for now, just do a post check
            _positionTableBys.PositionSettingsButton.Click(WebdriverCore,true,true);
            _positionTableBys.ServerBtnSelectAll.Click(WebdriverCore,true,true);
            _positionTableBys.PositionSettingBtnSave.Click(WebdriverCore, true, true);
            var wait = WebdriverCore.SetDefaultImplicitWait();
            wait.IgnoreExceptionTypes(typeof(StaleElementReferenceException));
            wait.Until(
                driver => GetPositionData().FirstOrDefault().Value.Keys.Count >= comparisonParameters.MinimumServers);

        }

        private bool BookSelected(CcComparisonParameters comparisonParameters, string btnBtnDefaultActive,
            CcComparisonParameters actual, TimeSpan wait, bool set = false)
        {
            bool bookSelected;
            switch (comparisonParameters.Book)
            {
                case "B":
                    bookSelected = SetAndCheckBook(PositionTableBys.BBookSelector, comparisonParameters, btnBtnDefaultActive, actual, wait, set);
                    break;
                case "A":
                    bookSelected = SetAndCheckBook(PositionTableBys.ABookSelector, comparisonParameters, btnBtnDefaultActive, actual, wait, set);
                    break;
                default:
                    throw new ArgumentException(
                        String.Format("comparisonParameters.Book {0} is not supported (yet)", comparisonParameters.Book),
                        comparisonParameters.Book);
            }
            return bookSelected;
        }

        private bool SetAndCheckBook(By book, CcComparisonParameters comparisonParameters, string btnBtnDefaultActive, CcComparisonParameters actual, TimeSpan wait, bool set)
        {
            var bookSelected = CheckBook(comparisonParameters.Book, btnBtnDefaultActive, actual,
                book, ShortTimeout());
            if (set && !bookSelected)
            {
                book.Click(WebdriverCore);
                bookSelected = CheckBook(comparisonParameters.Book, btnBtnDefaultActive, actual,
                    book, wait);
            }
            return bookSelected;
        }
        

        private void SetBook(CcComparisonParameters comparisonParameters)
        {
            if (!BookSelected(comparisonParameters, BtnBtnDefaultActive, null, ShortTimeout()))
            {
                BookSelected(comparisonParameters, BtnBtnDefaultActive, null, new TimeSpan(),true);
            }
        }

        private bool CheckBook(string book, string btnBtnDefaultActive, CcComparisonParameters actual, By bookSelector,
            TimeSpan wait)
        {
            WebdriverCore.WaitForElementToExist(bookSelector);
            var bookSelected = btnBtnDefaultActive.Equals(
                WebdriverCore.WaitForElementAttributeToHaveProperty(bookSelector,
                    HtmlAttributes.Class, btnBtnDefaultActive, wait), StringComparison.InvariantCulture);
            if (actual != null) actual.Book = bookSelected ? book : "?";
            // not going to search for the active book if not the expected one (for now)
            return bookSelected;
        }
        #endregion
    }
}