using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Windows.Forms.DataVisualization.Charting;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using log4net;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public class DataTablePair
    {
        public DataTablePair(DataTable baseTable, DataTable compareWithTable)
        {
            BaseTable = baseTable;
            CompareWithTable = compareWithTable;
        }

        public DataTable BaseTable { get; private set; }
        public DataTable CompareWithTable { get; private set; }
    }

    public class DataTablePairComparison
    {
        public DataTablePairComparison(DataTablePair dataTablePair, DataTableComparison dataTableComparison)
        {
            DataTablePair = dataTablePair;
            DataTableComparison = dataTableComparison;
        }

        public DataTablePair DataTablePair { get; private set; }
        public DataTableComparison DataTableComparison { get; private set; }
    }

    public class DataTablePairComparisonDictionary<T>
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (DataTablePairComparisonDictionary<T>));
        private readonly string[] _excludeColumns;
        private string _primaryKeyName;

        public DataTablePairComparisonDictionary()
        {
            DataTablePairComparisons = new Dictionary<T, DataTablePairComparison>();
        }

        public DataTablePairComparisonDictionary(string[] excludeColumns) : this()
        {
            _excludeColumns = excludeColumns;
        }

        public Dictionary<T, DataTablePairComparison> DataTablePairComparisons { get; private set; }

        public void Export(ExportParameters exportParameters)
        {
            _primaryKeyName =
                DataTablePairComparisons.Values.First().DataTablePair.BaseTable.PrimaryKey.Single().ColumnName;
            var actions = new List<Action<ExportParameters>>
            {
                ExportComparisonResults,
                ExportTrendData
            };

            foreach (var action in actions)
            {
                try
                {
                    action(exportParameters);
                }
                catch (Exception e)
                {
                    Log.Error(e);
                }
            }
        }

        private void ExportTrendData(ExportParameters exportParameters)
        {
            switch (exportParameters.ExportType)
            {
                case ExportTypes.DataTableToCsv:
                    ExportTrendDataToCsv(exportParameters);
                    break;
                default:
                    throw new ArgumentException("exportParameters");
            }
        }

        private void ExportTrendDataToCsv(ExportParameters exportParameters)
        {
            var rowNames = GetDistinctRowNames();
            var columnNames = GetDistinctColumnNames();
            var trendDataCollection = GetTrendDataCollection(rowNames, columnNames, _excludeColumns);
            foreach (var colList in trendDataCollection)
            {
                var path = Path.Combine(exportParameters.Path, colList.Key.RemoveWindowsUnfriendlyChars()) + "\\";
                Directory.CreateDirectory(path);
                foreach (var series in colList.Value)
                {
                    var resultName = String.Format("{0}_{1}", colList.Key.RemoveWindowsUnfriendlyChars(), series.Key).RemoveWindowsUnfriendlyChars();
                    try
                    {
                        series.Value.EnumerableToCsv(
                            String.Format("{0}{1}.{2}", path, resultName,
                                CsvParserExtensionMethods.csv), false);
                    }
                    catch (Exception e)
                    {
                        Log.Error(String.Format("Error outputting {0} to csv",resultName),e);
                    }
                    try
                    {
                        ExportChart(exportParameters, series, path, resultName);
                    }
                    catch (Exception e)
                    {
                        Log.Error(String.Format("Error outputting {0} as chart", resultName), e);
                    }
                }
            }
        }

        private static void ExportChart(ExportParameters exportParameters, KeyValuePair<string, List<TrendData>> series, string path, string resultName)
        {
            var orginalSeriesName = series.Value.First().OrginalSeriesName;
            var newSeriesName = series.Value.First().NewSeriesName;
            series.Value.EnumerableToLineGraph(
                new EnumerableToGraphExtensions.DataSeriesParameters
                {
                    PropertyName = "Key",
                    ChartValueType = ChartValueType.DateTime,
                    LabelStyleFormat = exportParameters.SeriesDateFormat //"yyyyMMddHHmmssfff"
                },
                new List<EnumerableToGraphExtensions.DataSeriesParameters>
                {
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "OrginalSeriesValue",
                        SeriesName = orginalSeriesName
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "NewSeriesValue",
                        SeriesName = newSeriesName
                    }
                }, new EnumerableToGraphExtensions.ChartOptions
                {
                    FilePath = path,
                    Name = resultName,
                    // AxisXMajorGridInterval = 1
                });
        }

        /// <summary>
        ///     Might need to have another think about this as this is potntially building up another large in memory collection,
        ///     when it should be possible to output 1 series at a time.
        ///     Should at least create a nicer return type - multiply nested lists are horrible!
        /// </summary>
        /// <param name="rowNames"></param>
        /// <param name="columnNames"></param>
        /// <param name="excludeColumns"></param>
        /// <returns></returns>
        private IEnumerable<KeyValuePair<string, List<KeyValuePair<string, List<TrendData>>>>> GetTrendDataCollection(
            List<string> rowNames, IEnumerable<string> columnNames,
            string[] excludeColumns)
        {
            var newSeriesName = DataTablePairComparisons.First().Value.DataTablePair.CompareWithTable.TableName;
            var originalSeriesName = DataTablePairComparisons.First().Value.DataTablePair.BaseTable.TableName;
            var colList = new List<KeyValuePair<string, List<KeyValuePair<string, List<TrendData>>>>>();
            foreach (var columnName in columnNames)
            {
                if (excludeColumns != null && !excludeColumns.Contains(columnName) &&
                    !columnName.Equals(_primaryKeyName))
                {
                    var rowlist = new List<KeyValuePair<string, List<TrendData>>>();
                    foreach (var rowName in rowNames)
                    {
                        var list = new List<TrendData>();
                        foreach (var dataTablePairComparison in DataTablePairComparisons)
                        {
                            var trendData = new TrendData
                            {
                                Key = dataTablePairComparison.Key.ToString(),
                                NewSeriesName = newSeriesName,
                                OrginalSeriesName = originalSeriesName,
                                NewSeriesValue =
                                    FindTableValueOrEmpty(dataTablePairComparison.Value.DataTablePair.CompareWithTable,
                                        rowName, columnName, "0"),
                                OrginalSeriesValue =
                                    FindTableValueOrEmpty(dataTablePairComparison.Value.DataTablePair.BaseTable,
                                        rowName, columnName, "0")
                            };
                            list.Add(trendData);
                        }
                        rowlist.Add(new KeyValuePair<string, List<TrendData>>(rowName, list));
                    }
                    colList.Add(new KeyValuePair<string, List<KeyValuePair<string, List<TrendData>>>>(columnName,
                        rowlist));
                }
            }
            return colList;
        }

        private static string FindTableValueOrEmpty(DataTable table, string rowName, string columnName,
            string defaultValue = null)
        {
            try
            {
                var s = table.Rows.Find(rowName)[columnName].ToString().Trim();
                return s.Length > 0 ? s : defaultValue;
            }
            catch (Exception)
            {
                //todo:- change the below line to a delegate call and move method to DataTable Extensions
                Log.ErrorFormat("Unable to find column {0} in row {1} in table {2}", columnName, rowName,
                    table.TableName);
                return defaultValue ?? String.Empty;
            }
        }

        /// <summary>
        ///     Assume a single primary key for now, and that both tables have the same primary key
        /// </summary>
        /// <returns></returns>
        private List<string> GetDistinctRowNames()
        {
            var baseRowNames = (DataTablePairComparisons.SelectMany(
                dataTablePairComparison => dataTablePairComparison.Value.DataTablePair.BaseTable.Rows.Cast<DataRow>(),
                (dataTablePairComparison, row) => row[_primaryKeyName].ToString())).ToList();
            var compareWithRowNames = (DataTablePairComparisons.SelectMany(
                dataTablePairComparison =>
                    dataTablePairComparison.Value.DataTablePair.CompareWithTable.Rows.Cast<DataRow>(),
                (dataTablePairComparison, row) => row[_primaryKeyName].ToString())).ToList();
            var rowNames = baseRowNames.Concat(compareWithRowNames).Distinct().ToList();
            return rowNames;
        }

        /// <summary>
        ///     get a unique list of column names  (e.g. server and Section names)
        /// </summary>
        /// <returns>a unique list of column names</returns>
        private IEnumerable<string> GetDistinctColumnNames()
        {
            var baseColumnNames = (DataTablePairComparisons.Values.SelectMany(
                dataTablePairComparison => dataTablePairComparison.DataTablePair.BaseTable.Columns.Cast<DataColumn>(),
                (dataTablePairComparison, col) => col.ColumnName)).ToList();

            var comparewithColumnNames = (DataTablePairComparisons.Values.SelectMany(
                dataTablePairComparison =>
                    dataTablePairComparison.DataTablePair.CompareWithTable.Columns.Cast<DataColumn>(),
                (dataTablePairComparison, col) => col.ColumnName)).ToList();

            var columnNames = baseColumnNames.Concat(comparewithColumnNames).Distinct().ToList();
            return columnNames;
        }

        private void ExportComparisonResults(ExportParameters exportParameters)
        {
            foreach (var dataTablePairComparison in DataTablePairComparisons)
            {
                exportParameters.FileName = dataTablePairComparison.Key.ToString();
                dataTablePairComparison.Value.DataTableComparison.CheckForDifferences(exportParameters, true);
            }
        }
    }

    /// <summary>
    ///     A Data point containing values being compared
    ///     TODO: create a generic version which allows types to be set for the key and value types, and thus allow diffs to be
    ///     calculated
    /// </summary>
    public class TrendData
    {
        /// <summary>
        ///     the index linking 2 values together represented as a string. Typically this will be a DateTime or TimeStamp, but
        ///     could be a positional index, or a database primary key etc.
        /// </summary>
        public string Key { get; set; }

        public string OrginalSeriesName { get; set; }
        public string NewSeriesName { get; set; }
        public string OrginalSeriesValue { get; set; }
        public string NewSeriesValue { get; set; }
    }
}