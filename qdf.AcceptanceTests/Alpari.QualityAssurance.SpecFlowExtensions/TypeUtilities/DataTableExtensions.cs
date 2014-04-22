namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    public static class DataTableExtensions
    {
        /// <summary>
        /// http://stackoverflow.com/questions/1398609/casting-generic-datatable-to-typed-datatable
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dtBase"></param>
        /// <returns></returns>
        public static T ConvertToTypedDataTable<T>(this DataTable dtBase) where T : DataTable, new()
        {
            T dtTyped = new T();
            dtTyped.Merge(dtBase);

            return dtTyped;
        }

        public static DataTableComparison Compare(this DataTable dtBase, DataTable compareWith)//, DataColumn[] keyColumns)
        {
            DataTableComparison comparison = new DataTableComparison();


            //get rows missing in compare with
            var baseRows = from DataRow row in dtBase.Rows
                           select row;

            var compRows = from DataRow row in compareWith.Rows
                           select row;

            //comparison.MissingInCompareWith = compRows.Except(baseRows, DataTableComparer<DataRow>.Instance).Select(x => x).ToList();
            comparison.MissingInCompareWith = baseRows.Except(compRows, DataTableComparer<DataRow>.Instance).Select(x => x).ToList();

            return comparison;

            ////var missingInCompareWith = from DataRow row in dtBase.Rows
            ////                           //where DataRow compareWithRow.Rows on dtBase.PrimaryKey != compareWith.PrimaryKey

            ////                                   where compareWith.Rows.Contains(dtBase.PrimaryKey as object[]) == false
            ////                                    select (
            ////                                            from keyColumn in dtBase.PrimaryKey
            ////                                            select row[keyColumn.ColumnName]
            ////                                           );
            ////comparison.MissingInCompareWith = missingInCompareWith.SelectMany(x=>x).ToList();

            ////TODO: factor out common code - =shouldn't need this, leaving as example of how to iterate over primary keys
            //var baseKeys = from DataRow row in dtBase.Rows
            //               select (
            //                       from keyColumn in dtBase.PrimaryKey
            //                       select row[keyColumn.ColumnName]
            //                      );

            //var compareWithKeys = from DataRow row in compareWith.Rows
            //                      select (
            //                              from keyColumn in compareWith.PrimaryKey
            //                              select row[keyColumn.ColumnName]
            //                             );
            ////also Except is returning all records, not just the ones missing in compare with
            ////var temp = baseKeys.Except(compareWithKeys); //;//missingInCompareWith.SelectMany(x => x).ToList();
            //var temp = from row in baseKeys
            //           //where compareWithKeys.Contains(row) == false // contains doesn't seem to work either
            //           select row;
            //comparison.MissingInCompareWith = temp.Select(x => x).ToList();
            ////reason except is returning all rows is that an IEqualityComparer is required. should be able to compare rows by primary key values. Default is to use refs, so it doesn't work as Row is a ref type

            ////todo . add a DataRowColumnChanged event handler to report diffs when merge happens. Primary keys need to be set
        }

        //public static DataTableComparison Compare<T>(this T dtBase, T compareWith) where T : DataTable,new()
        //{
        //    return dtBase.Compare(compareWith);
        //}

        /// <summary>
        /// class providing a comparer for Lionq functions Except, intersect, distinct etc for Data tables
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class DataTableComparer<T> : IEqualityComparer<T> where T : DataRow
        {
            public static DataTableComparer<T> Instance
            {
                get
                {
                    if (instance == null)
                    {
                        lock (syncRoot)
                        {
                            if (instance == null)
                            {
                                instance = new DataTableComparer<T>();
                            }
                        }
                    }
                    return instance;
                }
            }

            private static volatile DataTableComparer<T> instance;
            private static object syncRoot = new Object();

            /// <summary>
            /// use this before and after a comparison of a data table to ensure the instance is not locked to an incorrect T
            /// </summary>
            public void ResetInstance()
            {
                if (instance != null)
                {
                    instance = null;
                }
            }

            public bool Equals(T rowBase, T rowCompareWith)
            {
                bool equals = true;
                var keyValuesBase = GetKeyValues(rowBase);
                var keyValuesComp = GetKeyValues(rowCompareWith);
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
                int hashcode = 0;
                int hashcodeBase = 1;
                var keyValues = GetKeyValues(rowBase);
                var hashCodes = from value in keyValues
                                select value.GetHashCode();
                //hashcodeBase = hashCodes.ToList().GetHashCode();
                //var hashcodeList = hashCodes.ToList();
                //hashcodeBase = hashcodeList.GetHashCode();
                //hashing the list doesn't give reliable hashcodes, so iterate over the values, multiply them and then hash the result
                foreach (var hash in hashCodes)
                {
                    hashcodeBase *= hash;
                }
                hashcode = hashcodeBase.GetHashCode(); // always seems to return the same value as the input, so could save a method call here
                return hashcode;
            }

            private static List<object> GetKeyValues(T rowBase)
            {
                //could store the primary key in a static field too (and clear it in the ResetInstance method)
                var getKeyValues = from keyColumn in rowBase.Table.PrimaryKey
                                   select rowBase[keyColumn.ColumnName];

                return getKeyValues.ToList();
            }
        }
    }
}
