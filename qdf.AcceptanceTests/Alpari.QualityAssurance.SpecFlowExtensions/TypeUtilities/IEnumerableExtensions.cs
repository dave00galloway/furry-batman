﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     extension methods on IEnumerables
    ///     now used by a non test application (Alpari.QDF.UIClient.App), so some or all of the
    ///     Alpari.QualityAssurance.SpecFlowExtensions namespace should be extracted to a common package that can be used by
    ///     tests and applications alike. Shouldn't really use classes from test code in an application
    /// </summary>
    public static class EnumerableExtensions
    {
        /// <summary>
        ///     Method to output items in a list or other enumerable to CSV
        /// </summary>
        /// <typeparam name="T">The type of the enumerated items</typeparam>
        /// <param name="iEnumerable">the enumerated items</param>
        /// <param name="fileNamePath">output filename and path</param>
        /// <param name="removeReturns"></param>
        /// <param name="useHeadersToGetData">
        ///     set to true if the header list should be used to query the object. use this if you
        ///     suspect the object definition may have changes, and the actual object contains different properties to those
        ///     expected
        /// </param>
        /// <param name="headerSafeMode">
        ///     set to true if ther might be errors retrieving some property names.  use this if you
        ///     suspect the object definition may have changes, and the actual object contains different properties to those
        ///     expected
        /// </param>
        /// <param name="derivedOnly"></param>
        /// <param name="readableOnly">overrules all the other options. must be used with useHeadersToGetData = true </param>
        public static void EnumerableToCsv<T>(this IEnumerable<T> iEnumerable, string fileNamePath, bool removeReturns,
            bool useHeadersToGetData = false, bool headerSafeMode = false, bool derivedOnly = false,bool readableOnly = false)
        {
// ReSharper disable PossibleMultipleEnumeration
            if (iEnumerable == null || !iEnumerable.Any()) return;
            string headers;
            if (readableOnly)
            {
                headers = String.Join(",", typeof (T).GetPropertyNamesAsList(false, true,false));
                useHeadersToGetData = true;
            }
            else
            {
                headers = String.Join(",", typeof(T).GetPropertyNamesAsList(headerSafeMode, derivedOnly));
            }
            var csvFile = new StringBuilder();
            if (!File.Exists(fileNamePath))
            {
                if (headers.Length > 0)
                {
                    csvFile.AppendLine(headers);
                }
            }
            if (useHeadersToGetData && headers.Length > 0)
            {
                int lineCounter = 0;
                foreach (T item in iEnumerable)
                {
                    try
                    {
                        csvFile.AppendLine(String.Join(",",
                    item.GetObjectPropertyValuesAsList(headers.Split(','))
                        .Select(x => x.ToSafeString().StringToCsvCell(removeReturns))));
                    }
                    catch (Exception e)
                    {
                        e.ConsoleExceptionLogger(String.Format("exception thrown trying to write line {0}",lineCounter));
                    }
                    lineCounter = csvFile.DumpToCsvAtSpecifiedLineCount(fileNamePath, lineCounter);
                }
            }
            else
            {
                int lineCounter = 0;
                foreach (T item in iEnumerable)
                {
                    csvFile.AppendLine(String.Join(",",
                        item.GetObjectPropertyValuesAsList()
                            .Select(x => x.ToSafeString().StringToCsvCell(removeReturns))));
                    lineCounter = csvFile.DumpToCsvAtSpecifiedLineCount(fileNamePath, lineCounter);
                }
            }
            if (csvFile.Length > 0)
            {
                fileNamePath.DumpToCsv(csvFile);
            }
// ReSharper restore PossibleMultipleEnumeration
        }

        public static void ExportEnumerableByMethod<T>(this IEnumerable<T> enumerable, ExportParameters exportParameters)
        {
            switch (
                exportParameters.ExportType
                )
            {
                case ExportTypes.Csv:
                    exportParameters.DeleteIfOverwriting();
                    enumerable.EnumerableToCsv(
                        exportParameters.CsvFileNamePath(), false);
                    break;
                case ExportTypes.DataTableToCsv:
                    exportParameters.DeleteIfOverwriting();
                    var csvTable = enumerable.ConstructTableFromDataTableRows();
                    csvTable.DataTableToCsv(exportParameters.CsvFileNamePath());
                    break;
                case ExportTypes.Console:
                    throw  new NotImplementedException();
                case ExportTypes.DataTableToConsole:
                    var consoleTable = enumerable.ConstructTableFromDataTableRows();
                    consoleTable.DataTableToConsole();
                    break;
                case ExportTypes.Database:
                    throw new NotImplementedException();

                    //case ExportTypes.Unknown:
                default:
                    throw new ArgumentException(
                        exportParameters.ExportType.ToString()
                        );
            }
        }

        /// <summary>
        /// Create a data table where all columns are of type string, and fill rows with CSV friendly strings
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="rowsAsEnumerable"></param>
        /// <returns></returns>
        private static DataTable ConstructTableFromDataTableRows<T>(this IEnumerable<T> rowsAsEnumerable)
        {
            //construct a data table from the data table rows 
            var table = new DataTable();
            var rows = rowsAsEnumerable as List<DataRow>;
            foreach (DataColumn column in rows.First().Table.Columns)
            {
                table.Columns.Add(column.ColumnName, typeof (string));
            }
            foreach (DataRow row in rows)
            {
                //var newRowData = new object[]{ row.ItemArray.Select(x => x.ToString().StringToCsvCell(true)).ToArray()};
                //var newRowData = row.ItemArray.Select(x => x.ToString().StringToCsvCell(true));
                var newRowData = new object[row.ItemArray.Length];
                for (int i = 0; i < row.ItemArray.Length; i++)
                {
                    newRowData[i] = row.ItemArray[i].ToString().StringToCsvCell(true);
                }
                table.Rows.Add(newRowData);
            }
            table.AcceptChanges();
            return table;
        }

        public static int DumpToCsvAtSpecifiedLineCount(this StringBuilder csvFile, string fileNamePath, int lineCounter,
            int linesToDumpAt = 1000)
        {
            lineCounter++;
            if (lineCounter > linesToDumpAt)
            {
                fileNamePath.DumpToCsv(csvFile);
                csvFile.Clear();
                lineCounter = 0;
            }
            return lineCounter;
        }

        public static void DumpToCsv(this string fileNamePath, StringBuilder csvFile)
        {
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