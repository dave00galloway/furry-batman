using System;
using System.Data;
namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// a non-exhaustive definition of methods needed to implement a typed data table.
    /// some of the required methods are protected or internal, so can't be in an interface
    /// </summary>
    public interface ITypedDataTable
    {
        T ConvertIEnumerableToDataTable<T>(System.Collections.Generic.IEnumerable<T> enumeratedObjects) where T : System.Data.DataTable, new();
        //DataRow GetNewRow();
        //DataRow this[int idx] { get; }
    }
}
