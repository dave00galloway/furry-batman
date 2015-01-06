using System;
using System.Collections.Generic;
using System.Data;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public class DataTablePair
    {
        public DataTablePair(DataTable baseTable, DataTable compareWithTable)
        {
            BaseTable = baseTable;
            CompareWithTable = compareWithTable;
        }

        public DataTable BaseTable { get; private set; }
        public DataTable CompareWithTable { get; private set; }
    }

    public class DataTablePairComparison
    {
        public DataTablePairComparison(DataTablePair dataTablePair, DataTableComparison dataTableComparison)
        {
            DataTablePair = dataTablePair;
            DataTableComparison = dataTableComparison;
        }

        public DataTablePair DataTablePair { get; private set; }
        public DataTableComparison DataTableComparison { get; private set; }
    }

    public class DataTablePairComparisonDictionary<T>
    {
        public DataTablePairComparisonDictionary()
        {
            DataTablePairComparisons = new Dictionary<T, DataTablePairComparison>();
        }

        public Dictionary<T, DataTablePairComparison> DataTablePairComparisons { get; private set; }

        public void Export(ExportParameters exportParameters)
        {
            ExportComparisonResults(exportParameters);
            switch (exportParameters.ExportType)
            {
                case ExportTypes.DataTableToCsv:
                    
                    break;
                default:
                    throw new ArgumentException("exportParameters");
            }
        }

        private void ExportComparisonResults(ExportParameters exportParameters)
        {
            foreach (var dataTablePairComparison in DataTablePairComparisons)
            {
                exportParameters.FileName = dataTablePairComparison.Key.ToString();
                dataTablePairComparison.Value.DataTableComparison.CheckForDifferences(exportParameters, true);
            }
        }
    }
}