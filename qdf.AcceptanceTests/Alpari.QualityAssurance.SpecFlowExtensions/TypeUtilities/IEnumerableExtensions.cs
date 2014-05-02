using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// extension methods on IEnumerables
    /// </summary>
    public static class EnumerableExtensions
    {
        /// <summary>
        /// Method to output items in a list or other enumerable to CSV
        /// </summary>
        /// <typeparam name="T">The type of the enumerated items</typeparam>
        /// <param name="iEnumerable">the enumerated items</param>
        /// <param name="fileNamePath">output filename and path</param>
        /// <param name="useHeadersToGetData">set to true if the header list should be used to query the object. use this if you suspect the object definition may have changes, and the actual object contains different properties to those expected</param>
        /// <param name="headerSafeMode">set to true if ther might be errors retrieving some property names.  use this if you suspect the object definition may have changes, and the actual object contains different properties to those expected </param>
        public static void EnumerableToCsv<T>(this IEnumerable<T> iEnumerable, string fileNamePath,bool useHeadersToGetData = false, bool headerSafeMode = false)
        {
            string headers = String.Join(",", typeof(T).GetPropertyNamesAsList(headerSafeMode));
            var csvFile = new StringBuilder();
            if (!File.Exists(fileNamePath))
            {
                if (headers.Length>0)
                {
                    csvFile.AppendLine(headers);
                }
            }
            if (useHeadersToGetData && headers.Length>0)
            {
                foreach (T item in iEnumerable)
                {
                    csvFile.AppendLine(String.Join(",",
                        item.GetObjectPropertyValuesAsList(headers.Split(','))
                            .Select(x => x.ToSafeString().StringToCsvCell())));
                }                
            }
            else
            {
                foreach (T item in iEnumerable)
                {
                    csvFile.AppendLine(String.Join(",",
                        item.GetObjectPropertyValuesAsList()
                            .Select(x => x.ToSafeString().StringToCsvCell())));
                }                  
            }
            if (File.Exists(fileNamePath))
            {
                File.AppendAllText(fileNamePath, csvFile.ToString());
            }
            else
            {
                File.WriteAllText(fileNamePath, csvFile.ToString());
            }

        }
    }
}
