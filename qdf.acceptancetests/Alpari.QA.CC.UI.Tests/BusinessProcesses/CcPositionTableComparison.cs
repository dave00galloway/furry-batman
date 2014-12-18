using System.Data;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public class CcPositionTableComparison
    {
        public CcPositionTableComparison(CcComparisonParameters ccComparisonParameters)
        {
            CcComparisonParameters = ccComparisonParameters;
        }

        private CcComparisonParameters CcComparisonParameters { get; set; }

        public DataTableComparison ComparePositionTables()
        {
            DataTable currentTable = null;
            DataTable newTable = null;
            var currentDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcCurrent);
            var currentPositionsPage = new PositionTablePageObject(currentDriver);
            currentDriver.OpenPage();

            var newDriver = WebDriverCoreManager.Add(CcComparisonParameters.CcNew);
            var newPositionsPage = new PositionTablePageObject(newDriver);
            newDriver.OpenPage();

            //leaving driver creation outside of task until softkey sorted to make debugging easier

            var tasks = new Task[2]
            {
                Task.Factory.StartNew(() =>
                    currentTable = currentPositionsPage.GetPositionDataAsDataTableBySymbols())
                ,
                Task.Factory.StartNew(() =>
                    newTable = newPositionsPage.GetPositionDataAsDataTableBySymbols())
            };

            Task.WaitAll(tasks);
            //TODO:- provide mapping where the column names are different
            var diffs = currentTable.Compare(newTable, new[] {"Client Total", "Coverage Total", "Net Total"});
            //diffs.CheckForDifferences();
            return diffs;
        }
    }
}