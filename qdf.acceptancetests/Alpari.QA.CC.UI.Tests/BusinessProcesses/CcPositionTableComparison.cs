using System;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public class CcPositionTableComparison : ICcPositionTableComparison
    {
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
                        String.Format("{0}_{1}", CcComparisonParameters.CcCurrent, CcComparisonParameters.Book),
                        CcComparisonParameters.CcCurrent);
                _currentPositionsPage = _currentDriver.Create(CcComparisonParameters.CcCurrentVersion);
                _newDriver =
                    WebDriverCoreManager.Add(
                        String.Format("{0}_{1}", CcComparisonParameters.CcNew, CcComparisonParameters.Book),
                        CcComparisonParameters.CcNew);
                _newPositionsPage = _newDriver.Create(CcComparisonParameters.CcNewVersion);
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
        }

        public DataTableComparison ComparePositionTables()
        {
            var tables = RunComparison(_currentPositionsPage, _newPositionsPage);
            var diffs = Compare(tables);
            return diffs;
        }

        public DataTablePairComparisonDictionary<TimeStamp> MonitorPositions()
        {
            var startDate = DateTime.UtcNow;
            var stopAt = CcComparisonParameters.MonitorFor.GetTimeFromShortCode(startDate);
            var interval = CcComparisonParameters.MonitorEvery.GetTimeFromShortCode(startDate) - startDate;
            var dataTablePairComparisonDictionary = new DataTablePairComparisonDictionary<TimeStamp>(_excludeColumns);
            var stopwatch = new Stopwatch();
            while (DateTime.UtcNow < stopAt)
            {
                stopwatch.Restart();
                var timestamp = new TimeStamp(DateTime.UtcNow, "yyyyMMddHHmmssfff");
                var tables = RunComparison(_currentPositionsPage, _newPositionsPage);
                var diffs = Compare(tables);
                dataTablePairComparisonDictionary.DataTablePairComparisons.Add(timestamp,
                    new DataTablePairComparison(tables, diffs));
                stopwatch.Stop();
                Thread.Sleep(interval.Subtract(new TimeSpan(stopwatch.ElapsedMilliseconds)));
            }

            return dataTablePairComparisonDictionary;
        }

        /// <summary>
        /// ToDo - change to Extension method of a type implementing an interface extraceted from CcPositionTableComparison
        /// </summary>
        /// <param name="ccPositionTableComparison"></param>
        /// <param name="outputDirectory"></param>
        /// <param name="exportParameters"></param>
        public static void MonitorPositionsAndExport(ICcPositionTableComparison ccPositionTableComparison, ExportParameters exportParameters)
        {
            var monitoringresults = ccPositionTableComparison.MonitorPositions();
            exportParameters.SeriesDateFormat =
                monitoringresults.DataTablePairComparisons.Keys.First().ToStringFormat;
            monitoringresults.Export(exportParameters);
        }

        private DataTableComparison Compare(DataTablePair tables)
        {
            return tables.BaseTable.Compare(tables.CompareWithTable,
                //TODO:- provide mapping where the column names are different
                _excludeColumns);
        }

        private static DataTablePair RunComparison(IPositionTablePageObject currentPositionsPage,
            IPositionTablePageObject newPositionsPage)
        {
            DataTable currentTable = null;
            DataTable newTable = null;

            var tasks = new Task[2]
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