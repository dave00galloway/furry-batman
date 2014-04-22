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
        /// gets missing and added entries from datatables and returns them. Does an in console comparison of the data
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

                var commonRows = baseRows.Intersect(compRows, DataTableComparer<DataRow>.Instance);
                
                //todo:- allow an ovelroad to specify a delegate which writes to csv or db instead of console
                dtBase.ColumnChanged += new DataColumnChangeEventHandler(dtBase_ColumnChanged); // the event doesn't seem to fire on merges, but it does fire if you directly edit the row
                //dtBase.Merge(compareWith);

                ////stub a change
                //object[] findTheseVals = new object[2];
                //findTheseVals[0] = 1;
                //findTheseVals[1] = "Putin";

                //DataRow toChange = dtBase.Rows.Find(findTheseVals);

                ////toChange["Forenames"] = "Ian";
                //toChange["Forenames"] = "Vladimir";

                //get the non-primary key field columns
                List<DataColumn> columnsToUpdate = (from DataColumn col in dtBase.Columns
                                                    where dtBase.PrimaryKey.Contains(col) == false
                                                    select col).ToList();               
                foreach (var row in commonRows)
                {
                    //get the primary key values for the comp row
                    object[] findTheseVals = new object[dtBase.PrimaryKey.Count()];
                    for (int i = 0; i < findTheseVals.Length; i++)
                    {
                        findTheseVals[i] = row[dtBase.PrimaryKey[i]];
                    }

                    //get the equivalent row in the base table
                    DataRow toChange = dtBase.Rows.Find(findTheseVals);

                    //get the equivalent row in the comp table
                    DataRow toRead = compareWith.Rows.Find(findTheseVals);

                    //make edits to triggger the changed value validation
                    foreach (DataColumn column in columnsToUpdate)
                    {
                        toChange[column] = toRead[column.ColumnName];
                    }
                }

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
            bool changed = false;
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
            var type = e.ProposedValue.GetType();
            if (type.Equals(typeof(string)))
            {
                changed = (e.ProposedValue != e.Row[e.Column, DataRowVersion.Original]);
            }
            else
            {
                changed = !(e.ProposedValue.Equals(e.Row[e.Column, DataRowVersion.Original]));
            }

            if(changed)
            {
                Console.WriteLine("Column Changed : {0}, Original value : {1}, new value : {2}", e.Column.ColumnName, e.Row[e.Column, DataRowVersion.Original], e.ProposedValue);
                
            }
            else
            {
                e.Row.RejectChanges();
            }
            
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
