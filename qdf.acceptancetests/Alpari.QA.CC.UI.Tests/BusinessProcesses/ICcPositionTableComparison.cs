using System.Linq;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.UI.Tests.BusinessProcesses
{
    public interface ICcPositionTableComparison
    {
        /// <summary>
        ///     now using setter injection instead of constructor injection
        /// </summary>
        CcComparisonParameters CcComparisonParameters { get; set; }

        void OpenPages();
        DataTableComparison ComparePositionTables();
        DataTablePairComparisonDictionary<TimeStamp> MonitorPositions();
    }

    public static class CcPositionTableComparisonExtensions
    {
        /// <summary>
        /// ToDo - change to Extension method of a type implementing an interface extraceted from CcPositionTableComparison
        /// </summary>
        /// <param name="ccPositionTableComparison"></param>
        /// <param name="outputDirectory"></param>
        /// <param name="exportParameters"></param>
        public static void MonitorPositionsAndExport(this ICcPositionTableComparison ccPositionTableComparison, ExportParameters exportParameters)
        {
            var monitoringresults = ccPositionTableComparison.MonitorPositions();
            exportParameters.SeriesDateFormat =
                monitoringresults.DataTablePairComparisons.Keys.First().ToStringFormat;
            monitoringresults.Export(exportParameters);
        }
    }
}