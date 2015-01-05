using System.Collections.Generic;
using System.Data;

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

        public Dictionary<T,DataTablePairComparison> DataTablePairComparisons { get; private set; }
    }
}