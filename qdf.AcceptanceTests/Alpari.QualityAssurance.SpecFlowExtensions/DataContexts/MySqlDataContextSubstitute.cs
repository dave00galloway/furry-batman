using System;
using System.Data;
using System.Diagnostics.CodeAnalysis;
using MySql.Data.MySqlClient;

namespace Alpari.QualityAssurance.SpecFlowExtensions.DataContexts
{
    /// <summary>
    ///     Unable to get fully Linq compatible DataContext working either due to license contstrains (ALinq,  Devart) or not
    ///     being able to get DBMetal working
    ///     so using a substitute to connect to MySql
    ///     strongly typed DataTables give us all the functionality we need for aggregating the returned data
    /// </summary>
    public abstract class MySqlDataContextSubstitute : IDataContextSubstitute
    {
        public MySqlDataContextSubstitute(string connectionString)
        {
            myConnection = new MySqlConnection(connectionString);
        }

        public MySqlConnection myConnection { get; private set; }

        /// <summary>
        ///     retreives
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataSet SelectDataAsDataSet(string mySelectQuery)
        {
            var dataSet = new DataSet();
            dataSet.Clear();
            try
            {
                myConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataSet);
            }
            finally
            {
                myConnection.Close();
            }

            return dataSet;
        }

        /// <summary>
        ///     retreives
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataTable SelectDataAsDataTable(string mySelectQuery)
        {
            var dataTable = new DataTable();
            dataTable.Clear();
            try
            {
                myConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataTable);
            }
            finally
            {
                myConnection.Close();
            }

            return dataTable;
        }

        /// <summary>
        ///     retreives
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <returns></returns>
        public DataView SelectDataAsDataView(string mySelectQuery)
        {
            var dataTable = new DataTable();
            dataTable.Clear();
            try
            {
                myConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, myConnection);
                adapter.Fill(dataTable);
            }
            finally
            {
                myConnection.Close();
            }

            return dataTable.AsDataView();
        }

        /// <summary>
        ///     TODO replace with Log4Net logging
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <param name="adapter"></param>
        /// <param name="myConnection"></param>
        [SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities",
            Justification =
                "It is safe to suppress a warning from this rule if the command text does not contain any user input.")]
        private static void SetSelectCommandAndOutputToConsole(string mySelectQuery, MySqlDataAdapter adapter,
            MySqlConnection myConnection)
        {
            Console.WriteLine("executing query: \r\n {0}", mySelectQuery);
            adapter.SelectCommand = new MySqlCommand(mySelectQuery, myConnection);
        }
    }
}