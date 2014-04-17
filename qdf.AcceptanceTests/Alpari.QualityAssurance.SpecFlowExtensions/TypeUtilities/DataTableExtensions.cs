using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public static class DataTableExtensions
    {
        /// <summary>
        /// http://stackoverflow.com/questions/1398609/casting-generic-datatable-to-typed-datatable
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dtBase"></param>
        /// <returns></returns>
        public static T ConvertToTypedDataTable<T>(this System.Data.DataTable dtBase) where T : System.Data.DataTable, new()
        {
            T dtTyped = new T();
            dtTyped.Merge(dtBase);

            return dtTyped;
        }
    }
}
