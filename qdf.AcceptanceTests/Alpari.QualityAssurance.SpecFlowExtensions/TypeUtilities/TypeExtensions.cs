using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// Methods for finding info about types
    /// </summary>
    public static class TypeExtensions
    {
        /// <summary>
        /// Get a list of all the names of properties of a Type
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static List<string> GetPropertyNamesAsList(this Type type)
        {
            return type.GetProperties().Select(x => x.Name).ToList();
        }

        public static List<string> GetObjectPropertyValuesAsList(this object objectToSearch)
        {
            return objectToSearch.GetType().GetProperties().Select(x => x.GetValue(objectToSearch).ToString()).ToList();
        }

        //public static List<string> GetPropertyNamesAsList<T>()
        //{
        //    return T.GetProperties().Select(x => x.Name).ToList();
        //}
    }
}
