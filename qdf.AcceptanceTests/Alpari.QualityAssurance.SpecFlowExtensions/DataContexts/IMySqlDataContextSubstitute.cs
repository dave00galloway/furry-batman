using System.Data;

namespace Alpari.QualityAssurance.SpecFlowExtensions.DataContexts
{
    public interface IDataContextSubstitute
    {
        DataSet SelectDataAsDataSet(string mySelectQuery);
        // DataTable SelectDataAsDataTable(string mySelectQuery);
        DataTable SelectDataAsDataTable(string mySelectQuery, int timeout);
        DataTable SelectDataAsDataTable(string mySelectQuery, int timeout, bool outputToConsole);
        DataView SelectDataAsDataView(string mySelectQuery);

        
    }
}