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
        /// </summary>
        /// <param name="ccPositionTableComparison"></param>
        /// <param name="outputDirectory"></param>
        /// <param name="exportParameters"></param>
        public static void MonitorPositionsAndExport(this ICcPositionTableComparison ccPositionTableComparison, ExportParameters exportParameters)
        {
            var monitoringresults = ccPositionTableComparison.MonitorPositions();
            exportParameters.SeriesDateFormat =
                monitoringresults.DataTablePairComparisons.Keys.First().ToStringFormat;
            /*making a bit of an assumption here that file system is being used for export, when in fact the Book could mean that the data is written to a different table in a db or populate a table column
             * however, the \B could be removed and parsed to direct input to the correct table.
             * ideally we need a good general purpose field of Export parameters to define the lowest level of segregation
             */
            exportParameters.Segregator = ccPositionTableComparison.CcComparisonParameters.Book;
            exportParameters.Path += exportParameters.Segregator + "\\"; // this seems a bit daft, but it avoids having to work out the path in 2 places
            monitoringresults.Export(exportParameters);
        }
    }
}