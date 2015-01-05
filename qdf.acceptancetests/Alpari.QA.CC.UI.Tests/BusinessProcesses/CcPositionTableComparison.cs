using System;
using System.Data;
using System.Threading;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public class CcPositionTableComparison
    {
        private readonly CcComparisonParameters _ccComparisonParameters;
        private readonly IWebdriverCore _currentDriver;
        private readonly IPositionTablePageObject _currentPositionsPage;
        private readonly IWebdriverCore _newDriver;
        private readonly IPositionTablePageObject _newPositionsPage;
        public DataTablePairComparisonDictionary<TimeStamp> DataTablePairComparisonDictionary { get; set; }

        public CcPositionTableComparison(CcComparisonParameters ccComparisonParameters)
        {
            _ccComparisonParameters = ccComparisonParameters;
            _currentDriver = WebDriverCoreManager.Add(_ccComparisonParameters.CcCurrent);
            _currentPositionsPage = new PositionTablePageObject(_currentDriver);
            _newDriver = WebDriverCoreManager.Add(_ccComparisonParameters.CcNew);
            _newPositionsPage = new PositionTablePageObject(_newDriver);
            OpenPages();
        }

        public DataTableComparison ComparePositionTables()
        {
            var tables = RunComparison(_currentPositionsPage, _newPositionsPage);
            var diffs = Compare(tables);
            //diffs.CheckForDifferences();
            return diffs;
        }

        private static DataTableComparison Compare(DataTablePair tables)
        {
            return tables.BaseTable.Compare(tables.CompareWithTable,
                //TODO:- provide mapping where the column names are different
                new[] {"Client Total", "Coverage Total", "Net Total"});
        }

        private void OpenPages()
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

        public object MonitorPositions()
        {
            var startDate = DateTime.UtcNow;
            var stopAt = _ccComparisonParameters.MonitorFor.GetTimeFromShortCode(startDate);
            var interval = _ccComparisonParameters.MonitorEvery.GetTimeFromShortCode(startDate) - startDate;
            DataTablePairComparisonDictionary = new DataTablePairComparisonDictionary<TimeStamp>();
            while (DateTime.UtcNow < stopAt)
            {
                var timestamp = new TimeStamp( DateTime.UtcNow);
                var tables = RunComparison(_currentPositionsPage, _newPositionsPage);
                var diffs = Compare(tables);
                DataTablePairComparisonDictionary.DataTablePairComparisons.Add(timestamp,new DataTablePairComparison(tables,diffs));
                Thread.Sleep(interval);
            }

            return new object();
        }
    }
}