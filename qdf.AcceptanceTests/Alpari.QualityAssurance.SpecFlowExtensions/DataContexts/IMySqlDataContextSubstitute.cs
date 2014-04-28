using System.Data;

namespace Alpari.QualityAssurance.SpecFlowExtensions.DataContexts
{
    public interface IDataContextSubstitute
    {
        DataSet SelectDataAsDataSet(string mySelectQuery);
        DataTable SelectDataAsDataTable(string mySelectQuery);
        DataView SelectDataAsDataView(string mySelectQuery);
    }
}