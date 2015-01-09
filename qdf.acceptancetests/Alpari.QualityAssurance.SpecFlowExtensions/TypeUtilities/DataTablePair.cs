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
}