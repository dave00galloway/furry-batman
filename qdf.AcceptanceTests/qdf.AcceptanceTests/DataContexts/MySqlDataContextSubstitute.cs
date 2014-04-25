using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data;
using MySql;
using MySql.Data.MySqlClient;
using System.Data;

namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// Unable to get fully Linq compatible DataContext working either due to license contstrains (ALinq,  Devart) or not being able to get DBMetal working
    /// so using a substitute to connect to MySql
    /// strongly typed DataTables give us all the functionality we need for aggregating the returned data
    /// </summary>
    public abstract class MySqlDataContextSubstitute : qdf.AcceptanceTests.DataContexts.IDataContextSubstitute
    {
        public const string CC = "CC";
        public MySqlConnection myConnection { get; private set; }
        public MySqlDataContextSubstitute(string connectionString)
        {
            myConnection = new MySqlConnection(connectionString);
        }

        /// <summary>
        /// retreives 
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataSet SelectDataAsDataSet(string mySelectQuery)
        {
            DataSet dataSet = new DataSet();
            dataSet.Clear();
            try
            {
                myConnection.Open();
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                OutputQueryToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataSet);
            }
            finally
            {
                myConnection.Close();     
            }

            return dataSet;
        }

        /// <summary>
        /// retreives 
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataTable SelectDataAsDataTable(string mySelectQuery)
        {
            DataTable dataTable = new DataTable();
            dataTable.Clear();
            try
            {
                myConnection.Open();
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                OutputQueryToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataTable);
            }
            finally
            {
                myConnection.Close();
            }

            return dataTable;
        }

        /// <summary>
        /// retreives 
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataView SelectDataAsDataView(string mySelectQuery)
        {
            DataTable dataTable = new DataTable();
            dataTable.Clear();
            try
            {
                myConnection.Open();
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                OutputQueryToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataTable);
            }
            finally
            {
                myConnection.Close();
            }

            return dataTable.AsDataView();
        }

        /// <summary>
        /// TODO replace with Log4Net logging
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <param name="adapter"></param>
        /// <param name="myConnection"></param>
        private static void OutputQueryToConsole(string mySelectQuery, MySqlDataAdapter adapter, MySqlConnection myConnection)
        {
            Console.WriteLine("executing query: \r\n {0}", mySelectQuery);
            adapter.SelectCommand = new MySqlCommand(mySelectQuery, myConnection);
        }
    }
}
