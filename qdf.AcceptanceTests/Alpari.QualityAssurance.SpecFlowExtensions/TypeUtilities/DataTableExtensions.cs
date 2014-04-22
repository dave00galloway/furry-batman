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

        /// <summary>
        /// Must have primary keys set or the comparisons will fail
        /// </summary>
        /// <param name="dtBase"></param>
        /// <param name="compareWith"></param>
        /// <returns></returns>
        public static DataTableComparison Compare(this DataTable dtBase, DataTable compareWith)//, DataColumn[] keyColumns)
        {
            DataTableComparer<DataRow>.Instance.ResetInstance();
            try
            {
                DataTableComparison comparison = new DataTableComparison();

                //get rows missing in compare with
                var baseRows = from DataRow row in dtBase.Rows
                               select row;

                var compRows = from DataRow row in compareWith.Rows
                               select row;

                comparison.MissingInCompareWith = baseRows.Except(compRows, DataTableComparer<DataRow>.Instance).ToList();//.Select(x => x).ToList();
                comparison.AdditionalInCompareWith = compRows.Except(baseRows, DataTableComparer<DataRow>.Instance).ToList();

                //get diffs using an event handler for OnColumnChanged - failed
                
                dtBase.ColumnChanged += new DataColumnChangeEventHandler(dtBase_ColumnChanged); // the event doesn't seem to fire on merges, but it does fire if you directly edit the row
                //dtBase.Merge(compareWith);

                //stub a change
                object[] findTheseVals = new object[2];
                findTheseVals[0] = 1;
                findTheseVals[1] = "Putin";

                DataRow toChange = dtBase.Rows.Find(findTheseVals);
                //toChange.BeginEdit();
                toChange["Forenames"] = "Ian";
                //toChange.EndEdit();

                //var additions = dtBase.GetChanges(DataRowState.Added);
                //var additionRows = from DataRow row in additions.Rows
                //                   select row;
                //comparison.AdditionalInCompareWith = additionRows.ToList();
                //var changes = dtBase.GetChanges(DataRowState.Modified);

                // var addsAndChanges = dtBase.GetChanges(); // doesn't seem to pick up merges. does pick up direct edits, but the info from the event is richer, so we'll use that

                return comparison;
            }
            finally
            {
                DataTableComparer<DataRow>.Instance.ResetInstance();
                dtBase.RejectChanges();
                dtBase.ColumnChanged -= new DataColumnChangeEventHandler(dtBase_ColumnChanged);
            }

            ////todo . add a DataRowColumnChanged event handler to report diffs when merge happens. Primary keys need to be set
        }

        private static void dtBase_ColumnChanged(object sender, DataColumnChangeEventArgs e)
        {
            //throw new NotImplementedException();
            Console.WriteLine("Column Changed : {0}, Original value : {1}, new value : {2}", e.Column.ColumnName, e.Row[e.Column, DataRowVersion.Original],e.ProposedValue);
        }

        //public static DataTableComparison Compare<T>(this T dtBase, T compareWith) where T : DataTable,new()
        //{
        //    return dtBase.Compare(compareWith);
        //}

        /// <summary>
        /// class providing a comparer for Linq functions Except, intersect, distinct etc for Data tables
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
