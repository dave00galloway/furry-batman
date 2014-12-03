
namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     a non-exhaustive definition of methods needed to implement a typed data table.
    ///     some of the required methods are protected or internal, so can't be in an interface
    ///     Implement the methods, then unlink the interface
    /// </summary>
    public interface ITypedDataTable
    {
        //can't actually think of a way of iomplemeting these without gnerating recursive call errors
        //T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects) where T : DataTable, new();

        //T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects, string tableName, string[] primaryKeys)
        //    where T : DataTable, new();

        #region Constructor and StronglyTypedDataTable required methods

        //public PersonData()
        //{
        //    Columns.Add(new DataColumn("ID", typeof(ulong)));
        //    Columns.Add(new DataColumn("Forenames", typeof(string)));
        //    Columns.Add(new DataColumn("Lastname", typeof(string)));
        //    Columns.Add(new DataColumn("Age", typeof(UInt16)));
        //    Columns.Add(new DataColumn("Occupation", typeof(string)));
        //}
        //public PersonDataRow this[int idx]
        //{
        //    get { return (PersonDataRow)Rows[idx]; }
        //}

        //public void Add(PersonDataRow row)
        //{
        //    Rows.Add(row);
        //}

        //public void Remove(PersonDataRow row)
        //{
        //    Rows.Remove(row);
        //}

        //public PersonDataRow GetNewRow()
        //{
        //    PersonDataRow row = (PersonDataRow)NewRow();

        //    return row;
        //}

        //protected override Type GetRowType()
        //{
        //    return typeof(PersonDataRow);
        //}

        //protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        //{
        //    return new PersonDataRow(builder);
        //}

        #endregion
    }
}