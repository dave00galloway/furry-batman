using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

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
        /// <param name="removeReturns"></param>
        /// <param name="useHeadersToGetData">set to true if the header list should be used to query the object. use this if you suspect the object definition may have changes, and the actual object contains different properties to those expected</param>
        /// <param name="headerSafeMode">set to true if ther might be errors retrieving some property names.  use this if you suspect the object definition may have changes, and the actual object contains different properties to those expected </param>
        public static void EnumerableToCsv<T>(this IEnumerable<T> iEnumerable, string fileNamePath,bool removeReturns,bool useHeadersToGetData = false, bool headerSafeMode = false)
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
                            .Select(x => x.ToSafeString().StringToCsvCell(removeReturns))));
                }                
            }
            else
            {
                foreach (T item in iEnumerable)
                {
                    csvFile.AppendLine(String.Join(",",
                        item.GetObjectPropertyValuesAsList()
                            .Select(x => x.ToSafeString().StringToCsvCell(removeReturns))));
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

        public static void ExportEnumerableByMethod<T>(this IOrderedEnumerable<T> sumQuery, string exportMethod, ExportParameters exportParameters)
        {
            switch (
                (ExportTypes)
                    Enum.Parse(typeof(ExportTypes), CultureInfo.InvariantCulture.TextInfo.ToTitleCase(exportMethod.ToLower())))
            {
                case ExportTypes.Csv:
                    sumQuery.EnumerableToCsv(
                        String.Format("{0}{1}.{2}",exportParameters.FileNamePath,// DealReconciliationStepBase.ScenarioOutputDirectory,
                            "DiffDeltasByCombination", CsvParserExtensionMethods.csv), false);
                    break;
                case ExportTypes.Console:
                    throw new NotImplementedException();
                case ExportTypes.Database:
                    throw new NotImplementedException();

                //case ExportTypes.Unknown:
                default:
                    throw new ArgumentException(exportMethod.ToString(CultureInfo.InvariantCulture));
            }
        }
    }
}
