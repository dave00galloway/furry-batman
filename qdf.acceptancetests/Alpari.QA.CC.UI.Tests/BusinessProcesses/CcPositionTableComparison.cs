using System;
using System.Data;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using log4net;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public class CcPositionTableComparison : ICcPositionTableComparison
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(CcPositionTableComparison));
        private readonly string[] _excludeColumns;
        private CcComparisonParameters _ccComparisonParameters;
        private IWebdriverCore _currentDriver;
        private IPositionTablePageObject _currentPositionsPage;
        private IWebdriverCore _newDriver;
        private IPositionTablePageObject _newPositionsPage;

        public CcPositionTableComparison(string[] excludeColumns)
        {
            _excludeColumns = excludeColumns;
        }

        /// <summary>
        ///     now using setter injection instead of constructor injection
        /// </summary>
        public CcComparisonParameters CcComparisonParameters
        {
            get { return _ccComparisonParameters; }
            set
            {
                _ccComparisonParameters = value;
                _currentDriver =
                    WebDriverCoreManager.Add(
                        String.Format("{0}_{1}", _ccComparisonParameters.CcCurrent, _ccComparisonParameters.Book),
                        _ccComparisonParameters.CcCurrent);
                _currentPositionsPage = _currentDriver.Create(_ccComparisonParameters.CcCurrentVersion);
                _newDriver =
                    WebDriverCoreManager.Add(
                        String.Format("{0}_{1}", _ccComparisonParameters.CcNew, _ccComparisonParameters.Book),
                        _ccComparisonParameters.CcNew);
                _newPositionsPage = _newDriver.Create(_ccComparisonParameters.CcNewVersion);
                OpenPages();
            }
        }

        public void OpenPages()
        {
            if (!_currentPositionsPage.IsDisplayed())
            {
                _currentDriver.OpenPage();
            }
            if (!_newPositionsPage.IsDisplayed())
            {
                _newDriver.OpenPage();
            }
            _currentPositionsPage.ConfigurePositionTable(_ccComparisonParameters);
            _newPositionsPage.ConfigurePositionTable(_ccComparisonParameters);
        }

        public DataTableComparison ComparePositionTables()
        {
            var tables = GetComparisonData(_currentPositionsPage, _newPositionsPage);
            var diffs = Compare(tables);
            return diffs;
        }

        public DataTablePairComparisonDictionary<TimeStamp> MonitorPositions()
        {
            var startDate = DateTime.UtcNow;
            var stopAt = _ccComparisonParameters.MonitorFor.GetTimeFromShortCode(startDate);
            var interval = _ccComparisonParameters.MonitorEvery.GetTimeFromShortCode(startDate) - startDate;
            var dataTablePairComparisonDictionary = new DataTablePairComparisonDictionary<TimeStamp>(_excludeColumns);
            var stopwatch = new Stopwatch();
            while (DateTime.UtcNow < stopAt)
            {
                stopwatch.Restart();
                try
                {
                    var timestamp = new TimeStamp(DateTime.UtcNow, "yyyyMMddHHmmssfff");
                    var tables = GetComparisonData(_currentPositionsPage, _newPositionsPage);
                    var diffs = Compare(tables);
                    dataTablePairComparisonDictionary.DataTablePairComparisons.Add(timestamp,
                        new DataTablePairComparison(tables, diffs));
                }
                catch (Exception e)
                {
                    Log.Warn(String.Format("Error monitoring positions in with for book {0}",_ccComparisonParameters.Book),e);
                }
                stopwatch.Stop();
                Thread.Sleep(interval.Subtract(new TimeSpan(stopwatch.ElapsedMilliseconds)));
            }
            return dataTablePairComparisonDictionary;
        }

        private DataTableComparison Compare(DataTablePair tables)
        {
            try
            {
                return tables.BaseTable.Compare(tables.CompareWithTable,
                    //TODO:- provide mapping where the column names are different
                    _excludeColumns);
            }
            catch (Exception e)
            {
                Log.Warn(string.Format("error comparing tables for for book {0}",_ccComparisonParameters.Book),e);
                return null;
            }
        }

        private static DataTablePair GetComparisonData(IPositionTablePageObject currentPositionsPage,
            IPositionTablePageObject newPositionsPage)
        {
            DataTable currentTable = null;
            DataTable newTable = null;

            var tasks = new Task[]
            {
                Task.Factory.StartNew(() =>
                    currentTable = currentPositionsPage.GetPositionDataAsDataTableBySymbols())
                ,
                Task.Factory.StartNew(() =>
                    newTable = newPositionsPage.GetPositionDataAsDataTableBySymbols())
            };

            Task.WaitAll(tasks);

            return new DataTablePair(currentTable, newTable);
        }
    }
}