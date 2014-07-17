using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using NUnit.Framework;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public static class DataTableExtensions
    {
        /// <summary>
        ///     http://stackoverflow.com/questions/1398609/casting-generic-datatable-to-typed-datatable
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dtBase"></param>
        /// <returns></returns>
        public static T ConvertToTypedDataTable<T>(this DataTable dtBase) where T : DataTable, new()
        {
            var dtTyped = new T();
            dtTyped.Merge(dtBase);

            return dtTyped;
        }

        /// <summary>
        ///     send the datatable to csv file. if the file exists, append and don't write headers
        /// </summary>
        /// <param name="dataTable"></param>
        /// <param name="fileNamePath"></param>
        /// <param name="setCapacity"></param>
        public static void DataTableToCsv(this DataTable dataTable, string fileNamePath, bool setCapacity = false)
        {
            StringBuilder csvFile;
            if (setCapacity)
            {
                csvFile = new StringBuilder(10000000*2);
            }
            else
            {
                csvFile = new StringBuilder();
            }


            if (!File.Exists(fileNamePath))
            {
                string headers = String.Join(",",
                    (dataTable.Columns.Cast<DataColumn>().Select(dataColumn => dataColumn.ColumnName).ToArray()));
                if (headers.Length > 0)
                {
                    csvFile.AppendLine(headers);
                }
            }
            AppendRowValuesAsCsvRecords(dataTable, csvFile, fileNamePath);
            if (csvFile.Length > 0)
            {
                fileNamePath.DumpToCsv(csvFile);
            }
        }

        public static void DataTableToConsole(this DataTable consoleTable)
        {
            Console.WriteLine(String.Join(",",
                (from DataColumn column in consoleTable.Rows.Cast<DataRow>().First().Table.Columns
                    select column.ColumnName)));
            foreach (DataRow item in consoleTable.Rows)
            {
                Console.WriteLine(String.Join(",",
                    item.ItemArray.Select(x => CsvParser.StringToCsvCell(x.ToString()))));
            }
        }

        private static void AppendRowValuesAsCsvRecords(DataTable dataTable, StringBuilder csvFile, string fileNamePath)
        {
            if (dataTable.Rows == null) return;
            int lineCounter = 0;
            foreach (DataRow dataRow in dataTable.Rows)
            {
                csvFile.AppendLine(String.Join(",",
                    (dataRow.ItemArray.Select(x => x.ToSafeString().StringToCsvCell()).ToArray())));
                lineCounter = csvFile.DumpToCsvAtSpecifiedLineCount(fileNamePath, lineCounter);
            }
        }

        /// <summary>
        ///     Must have primary keys set or the comparisons will fail
        ///     gets missing and added entries from datatables and returns them. Does an in console comparison of the data
        /// </summary>
        /// <param name="dtBase"></param>
        /// <param name="compareWith"></param>
        /// <param name="excludeColumns"></param>
        /// <param name="includeColumns"></param>
        /// <param name="outputMatches"></param>
        /// <returns></returns>
        public static DataTableComparison Compare(this DataTable dtBase, DataTable compareWith,
            string[] excludeColumns = null, string[] includeColumns = null, bool outputMatches = false,
            bool removeReturns = false)
            //, DataColumn[] keyColumns)
        {
            //DataTableComparer<DataRow>.Instance.ResetInstance();
            var comparer = new DataTableComparer<DataRow>(dtBase, compareWith);
            var comparison = new DataTableComparison();

            //get rows missing in compare with
            List<DataRow> baseRows = dtBase.Rows.Cast<DataRow>().Select(row => row).ToList();

            List<DataRow> compRows = compareWith.Rows.Cast<DataRow>().Select(row => row).ToList();

            comparison.MissingInCompareWith =
                baseRows.Except(compRows,
                    //DataTableComparer<DataRow>.Instance
                    comparer
                    ).ToList();
            comparison.AdditionalInCompareWith =
                compRows.Except(baseRows,
                    //DataTableComparer<DataRow>.Instance
                    comparer
                    ).ToList();

            IEnumerable<DataRow> commonRows = baseRows.Intersect(compRows,
                //DataTableComparer<DataRow>.Instance
                comparer
                );

            // dtBase.ColumnChanged += new DataColumnChangeEventHandler(dtBase_ColumnChanged); // the event doesn't seem to fire on merges, but it does fire if you directly edit the row. required some really fiddly work to get right, so abandoned


            //get the non-primary key field columns
            IEnumerable<DataColumn> columnQuery = from DataColumn col in dtBase.Columns
                //where dtBase.PrimaryKey.Contains(col) == false
                                                  where comparer.PrimaryKeys.Contains(col) == false
                select col;
            if (excludeColumns != null)
            {
                columnQuery = columnQuery.Where(col => !excludeColumns.Contains(col.ColumnName));
            }
            if (includeColumns != null)
            {
                columnQuery = columnQuery.Where(col => includeColumns.Contains(col.ColumnName));
            }
            List<DataColumn> columnsToCompare = columnQuery.ToList();

            //when the format for this is agreed, could create a strongly typed datatable for the comparisons

            //DataTable comparisonDiffs = SetupComparisonDiffsTable(dtBase.PrimaryKey);
            DataTable comparisonDiffs = SetupComparisonDiffsTable(comparer.PrimaryKeys);
            comparison.FieldDifferences = comparisonDiffs;
            foreach (DataRow row in commonRows)
            {
                //get the primary key values for the comp row
                //var findTheseVals = new object[dtBase.PrimaryKey.Count()];
                var findTheseVals = new object[comparer.PrimaryKeys.Count()];
                for (int i = 0; i < findTheseVals.Length; i++)
                {
                    //findTheseVals[i] = row[dtBase.PrimaryKey[i]];
                    findTheseVals[i] = row[comparer.PrimaryKeys[i]];
                }

                //DataRow sourceRow;
                DataRow newRow;
                if (comparer.KeysMatch)
                {
                    //get the equivalent row in the base table
                    //sourceRow = dtBase.Rows.Find(findTheseVals);

                    //get the equivalent row in the comp table
                    newRow = compareWith.Rows.Find(findTheseVals);
                }
                else
                {
                    //get the equivalent row in the base table
                    //sourceRow = dtBase.Rows.FindRow(findTheseVals, comparer.PrimaryKeys);
                    //use row

                    //opportunity to speed up here - only need to find one row, should be able to use common rows for one of base or compare with
                    //get the equivalent row in the comp table
                    newRow = compareWith.Rows.FindRow(findTheseVals, comparer.PrimaryKeys);
                }

                foreach (DataColumn column in columnsToCompare)
                {
                    //sourceRow[column].CompareWith(newRow[column.ColumnName], column, findTheseVals, comparisonDiffs,
                    //    outputMatches, removeReturns);
                    row[column].CompareWith(newRow[column.ColumnName], column, findTheseVals, comparisonDiffs,
                        outputMatches, removeReturns);
                }
            }

            return comparison;
        }

        /// <summary>
        /// This is going to be very slow. need to find a quicker method for large datasets
        /// </summary>
        /// <param name="dataRowCollection"></param>
        /// <param name="objectsToFind"></param>
        /// <param name="dataColumns"></param>
        /// <returns></returns>
        public static DataRow FindRow(this DataRowCollection dataRowCollection,object[] objectsToFind,  DataColumn[] dataColumns)
        {
            foreach (DataRow row in dataRowCollection)
            {
                bool found = true;
                for (int i = 0; i < dataColumns.Length; i++)
                {
                    string type = dataColumns[i].DataType.GetDataType();
                    string difference = ValueComparison(row.ItemArray[dataColumns[i].Ordinal], objectsToFind[i], type);
                    if (difference != null)
                    {
                        found = false;
                        break;
                    }
                }

                if (found)
                {
                    return row;
                }
            }
            return null;
        }

        private static DataTable SetupComparisonDiffsTable(DataColumn[] primaryKeys)
        {
            var table = new DataTable("comparsionDiffs");
            for (int i = 0; i < primaryKeys.Count(); i++)
            {
                var keyColumn = new DataColumn
                {
                    DataType = Type.GetType("System.String"),
                    ColumnName = string.Format("comparisonKey{0}", i)
                };
                table.Columns.Add(keyColumn);
            }

            var column = new DataColumn {DataType = Type.GetType("System.String"), ColumnName = "column"};
            table.Columns.Add(column);

            column = new DataColumn {DataType = Type.GetType("System.String"), ColumnName = "original"};
            table.Columns.Add(column);

            column = new DataColumn {DataType = Type.GetType("System.String"), ColumnName = "newValue"};
            table.Columns.Add(column);

            column = new DataColumn {DataType = Type.GetType("System.String"), ColumnName = "difference"};
            table.Columns.Add(column);

            column = new DataColumn {DataType = Type.GetType("System.String"), ColumnName = "type"};
            table.Columns.Add(column);

            return table;
        }

        public static void CompareWith(this object p1, object p2, DataColumn column, object[] primaryKeyValues,
            DataTable diffsTable, bool outputMatches = false, bool removeReturns = false)
        {
            //string difference = null;

            //get the type as an "enum"
            string type = column.DataType.GetDataType();

            string difference = ValueComparison(p1, p2, type);

            if (difference != null | outputMatches)
            {
                DataRow diffRow = diffsTable.NewRow();
                for (int i = 0; i < primaryKeyValues.Count(); i++)
                {
                    diffRow[string.Format("comparisonKey{0}", i)] = primaryKeyValues[i];
                }
                diffRow["column"] = column.ColumnName;
                diffRow["original"] = p1;
                diffRow["newValue"] = p2;
                if (difference != null)
                {
                    diffRow["difference"] = difference;
                }
                else
                {
                    diffRow["difference"] = ""; //type.GetDefaultValueForType();
                }

                diffRow["type"] = type;
                if (removeReturns)
                {
                    for (int index = 0; index < diffRow.ItemArray.Length; index++)
                    {
                        string item = diffRow.ItemArray[index].ToString().StringToCsvCell(true);
                        //diffRow.ItemArray[index] = item;
                        diffRow[index] = item;
                    }
                }
                diffsTable.Rows.Add(diffRow);
            }
        }

        private static string ValueComparison(object p1, object p2, string type)
        {
            #region downcast the object to its type, and compare. if different, create a new row and return it and a calcualtion of difference
            string difference = null;
            switch (type.ToUpper())
            {
                case TypeExtensions.Byte:
                    // difference = ((byte) p1 - (byte) p2 == 0 )? null : (byte) p1 - (byte) p2
                    int bdiff = (byte) p1 - (byte) p2;
                    if (bdiff != 0)
                    {
                        difference = bdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Sbyte:
                    int sdiff = (sbyte) p1 - (sbyte) p2;
                    if (sdiff != 0)
                    {
                        difference = sdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Short:
                    int shdiff = (short) p1 - (short) p2;
                    if (shdiff != 0)
                    {
                        difference = shdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Ushort:
                    int ushdiff = (short) p1 - (short) p2;
                    if (ushdiff != 0)
                    {
                        difference = ushdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Int:
                    int idiff = (int) p1 - (int) p2;
                    if (idiff != 0)
                    {
                        difference = idiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "INT16":
                    int i16Diff = (Int16) p1 - (Int16) p2;
                    if (i16Diff != 0)
                    {
                        difference = i16Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "INT32":
                    int i32Diff = (Int32) p1 - (Int32) p2;
                    if (i32Diff != 0)
                    {
                        difference = i32Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "INT64":
                    long i64Diff = (Int64) p1 - (Int64) p2;
                    if (i64Diff != 0)
                    {
                        difference = i64Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Uint:
                    uint uidiff = (uint) p1 - (uint) p2;
                    if (uidiff != 0)
                    {
                        difference = uidiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "UINT16":
                    int ui16Diff = (UInt16) p1 - (UInt16) p2;
                    if (ui16Diff != 0)
                    {
                        difference = ui16Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "UINT32":
                    uint ui32Diff = (UInt32) p1 - (UInt32) p2;
                    if (ui32Diff != 0)
                    {
                        difference = ui32Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case "UINT64":
                    ulong ui64Diff = (UInt64) p1 - (UInt64) p2;
                    if (ui64Diff != 0)
                    {
                        difference = ui64Diff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Long:
                    long ldiff = (long) p1 - (long) p2;
                    if (ldiff != 0)
                    {
                        difference = ldiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Ulong:
                    ulong uldiff = (ulong) p1 - (ulong) p2;
                    if (uldiff != 0)
                    {
                        difference = uldiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Float:
                    float fdiff = (float) p1 - (float) p2;
                    if (Math.Abs(fdiff) > 0)
                    {
                        difference = fdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Double:
                    double dbldiff = (double) p1 - (double) p2;
                    if (Math.Abs(dbldiff) > 0)
                    {
                        difference = dbldiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                case TypeExtensions.Decimal:
                    decimal decdiff = (decimal) p1 - (decimal) p2;
                    if (decdiff != 0)
                    {
                        difference = decdiff.ToString(CultureInfo.InvariantCulture);
                    }
                    break;
                    //TypeExtensions.CHAR
                    //TypeExtensions.STRING
                    //TypeExtensions.BOOL
                    //TypeExtensions.OBJECT // date - although maybe create a subtraction for date?
                default:
                    difference = CatchAssertion(p1, p2);
                    break;
            }

            #endregion

            return difference;
        }

        public static string CatchAssertion(object p1, object p2)
        {
            string difference = null;
            try
            {
                Assert.AreEqual(p1, p2);
            }
            catch (Exception e)
            {
                difference = e.Message;
            }
            return difference;
        }

// ReSharper disable once UnusedMember.Local
// ReSharper disable once UnusedParameter.Local
        private static void dtBase_ColumnChanged(object sender, DataColumnChangeEventArgs e)
        {
            bool changed;
            //throw new NotImplementedException();
            //if (e.ProposedValue.Equals(e.Row[e.Column, DataRowVersion.Original])) // will fail on reference types including string
            //if (e.ProposedValue == e.Row[e.Column, DataRowVersion.Original]) // will fail on reference types other than string, but we probably shouldn't have complex datatypes in these comparisons - doesn't work for numbers!
            //// dynamic type = e.ProposedValue.GetType();
            //var E = e;
            //switch (typeof(E.ProposedValue.GetType()))
            //{
            //    default:
            //        break;
            //}

            //TODO:- create a class in TypeUtilities that can return an enum representing type, and downcast the objects to their types based on the enum
            //this is required to work out the difference between vlaues (numbers dates, and if anything else, toString and assert them)
            Type type = e.ProposedValue.GetType();
// ReSharper disable once CheckForReferenceEqualityInstead.1
            if (type.Equals(typeof (string)))
            {
                changed = (e.ProposedValue != e.Row[e.Column, DataRowVersion.Original]);
            }
            else
            {
                changed = !(e.ProposedValue.Equals(e.Row[e.Column, DataRowVersion.Original]));
            }

            if (changed)
            {
                Console.WriteLine("Column Changed : {0}, Original value : {1}, new value : {2}", e.Column.ColumnName,
                    e.Row[e.Column, DataRowVersion.Original], e.ProposedValue);
            }
            else
            {
                e.Row.RejectChanges();
            }
        }

        /// <summary>
        ///     class providing a comparer for Linq functions Except, intersect, distinct etc for Data tables
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class DataTableComparer<T> : IEqualityComparer<T> where T : DataRow
        {
            public DataTableComparer(DataTable dtBase, DataTable compareWith)
            {
                DtBasePrimaryKeys = dtBase.PrimaryKey.Select(keyColumn => keyColumn).ToList();
                DtCompareWithPrimaryKeys = compareWith.PrimaryKey.Select(keyColumn => keyColumn).ToList();
                MatchingKeyNames = DtBasePrimaryKeys.Select(x => x.ColumnName).ToList()
                    .Intersect(DtCompareWithPrimaryKeys.Select(x => x.ColumnName).ToList()).ToList();
                KeysMatch = MatchingKeyNames.Count().Equals(DtBasePrimaryKeys.Count) && MatchingKeyNames.Count().Equals(DtCompareWithPrimaryKeys.Count);
                PrimaryKeys = KeysMatch
                    ? DtBasePrimaryKeys.ToArray()
                    : DtBasePrimaryKeys.Where(x => MatchingKeyNames.Any(k => String.Equals(k, x.ColumnName))).ToArray();
            }

            private List<DataColumn> DtCompareWithPrimaryKeys { get; set; }
            private List<DataColumn> DtBasePrimaryKeys { get; set; }
            private List<string> MatchingKeyNames { get; set; }
            public bool KeysMatch { get; private set; }
            public DataColumn[] PrimaryKeys { get; private set; }


            public bool Equals(T rowBase, T rowCompareWith)
            {
                bool equals = true;
                List<object> keyValuesBase = GetKeyValues(rowBase);
                List<object> keyValuesComp = GetKeyValues(rowCompareWith);
                for (int i = 0; i < keyValuesBase.Count(); i++)
                {
                    if (keyValuesBase[i].ToString() != keyValuesComp[i].ToString())
                    {
                        equals = false;
                        break;
                    }
                }
                return equals;
            }

            public int GetHashCode(T rowBase)
            {
                List<object> keyValues = GetKeyValues(rowBase);
                IEnumerable<int> hashCodes = from value in keyValues
                    select value.GetHashCode();
                //iterate over the values, multiply them and then hash the result
                int hashcode = hashCodes.Aggregate(1, (current, hash) => current*hash);
                return hashcode;
            }

            private List<object> GetKeyValues(T rowBase)
            {
                IEnumerable<object> getKeyValues;
                if (KeysMatch)
                {
                    getKeyValues = from keyColumn in rowBase.Table.PrimaryKey
                        select rowBase[keyColumn.ColumnName];
                }
                else
                {
                    getKeyValues = from columnName in MatchingKeyNames
                        select rowBase[columnName];
                }

                return getKeyValues.ToList();
            }
        }
    }
}