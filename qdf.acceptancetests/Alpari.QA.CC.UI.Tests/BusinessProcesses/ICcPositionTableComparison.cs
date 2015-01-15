using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public interface ICcPositionTableComparison
    {
        /// <summary>
        ///     now using setter injection instead of constructor injection
        /// </summary>
        CcComparisonParameters CcComparisonParameters { get; set; }

        IPositionTablePageObject CurrentPositionsPage { get; }
        IPositionTablePageObject NewPositionsPage { get; }

        void OpenPages();
        DataTableComparison ComparePositionTables();
        DataTablePairComparisonDictionary<TimeStamp> MonitorPositions();
    }
}