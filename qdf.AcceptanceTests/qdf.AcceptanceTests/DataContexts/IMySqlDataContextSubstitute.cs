using System;
namespace qdf.AcceptanceTests.DataContexts
{
    public interface IDataContextSubstitute
    {
        System.Data.DataSet SelectDataAsDataSet(string mySelectQuery);
        System.Data.DataTable SelectDataAsDataTable(string mySelectQuery);
        System.Data.DataView SelectDataAsDataView(string mySelectQuery);
    }
}
