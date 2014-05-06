using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using Microsoft.VisualBasic.FileIO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class CsvParserExtensionMethods
    {
        public static string EscapeCommasIfInEscapeList(this string val, int[] columnsToEscape,
            KeyValuePair<string, int> column)
        {
            if (columnsToEscape.Contains(column.Value))
            {
                val = CsvParser.StringToCsvCell(val);
            }
            return val;
        }

        public static List<string> GetValuesFromCsvRow(this string row, string delimiter)
        {
            using (var sr = new StringReader(row))
            {
                var parser = new TextFieldParser(sr);
                parser.SetDelimiters(delimiter);
                // ReSharper disable once AssignNullToNotNullAttribute
                return parser.ReadFields().Select(x => x.Trim()).ToList();
            }
        }

        public static int GetColumnIndex(this IList<string> columnNames, string columnName)
        {
            return columnNames.IndexOf(columnName);
        }

        public static List<T> CsvToList<T>(this string fileNamePath, string delimiter) where T : new()
        {
            string[] unparsedFile = File.ReadAllLines(fileNamePath);
            IList<string> headers = unparsedFile.First().GetValuesFromCsvRow(delimiter);
            Dictionary<string, int> columnMap = headers.ToDictionary(header => header, headers.GetColumnIndex);
            List<T> parsedFile = new List<T>();
            long line = 1;
            Type type;
            try
            {
                type = Type.GetType(typeof(T).FullName, true);
            }
            catch (Exception e)
            {
                var assemblyQualifiedName = typeof (T).AssemblyQualifiedName;

                if (assemblyQualifiedName != null)
                {
                    type = Type.GetType(assemblyQualifiedName, true);
                }
                else
                {
                    throw new Exception("could not resolve a fully qualifed name for T ",e);
                }
            }
            foreach (string s in unparsedFile.Skip(1))
            {
                T newT = default (T);
                try
                {
                    try
                    {
                        IList<string> row = s.GetValuesFromCsvRow(delimiter);
                        var instance = (T) Activator.CreateInstance(type);
                        foreach (var pair in columnMap)
                        {
                            try
                            {
                                PropertyInfo prop = type.GetProperty(pair.Key);
                                try
                                {
                                    instance.SetValue(prop, row[columnMap[pair.Key]]);
                                }
                                catch (InvalidCastException e)
                                {
                                    //var value = Enum.Parse(prop.GetType(), row[columnMap[pair.Key]]);
                                    var enumProp = type.GetProperty(pair.Key).PropertyType;
                                    var value = Enum.Parse(enumProp, row[columnMap[pair.Key]]);
                                    instance.SetValue(prop, value);
                                }
                            }
                            catch (Exception e)
                            {
                                e.ConsoleExceptionLogger(
                                    string.Format(
                                        "unable to get value for property {0} in line {1}. values = {2}. filename = {3}",
                                        pair.Key, line, s, fileNamePath));
                            }
                        }
                        newT = instance;
                    }
                    catch (Exception e)
                    {
                        e.ConsoleExceptionLogger(
                            string.Format("unable to get values for line {0}. values = {1} , file = {2}", line, s,
                                fileNamePath));
                    }
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger(string.Format("unable to get values for a line,  , file = {0}",
                        fileNamePath));
                }
                parsedFile.Add(newT);
                line++;
            }
            return parsedFile;
        }
    }
}