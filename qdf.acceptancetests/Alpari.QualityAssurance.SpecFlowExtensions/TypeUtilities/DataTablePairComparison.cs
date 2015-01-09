namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
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
}