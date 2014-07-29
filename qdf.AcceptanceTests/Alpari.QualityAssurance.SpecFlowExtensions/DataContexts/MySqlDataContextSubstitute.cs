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
        protected MySqlDataContextSubstitute(string connectionString)
        {
            MyConnection = new MySqlConnection(connectionString);
        }

// ReSharper disable once MemberCanBePrivate.Global - might be needed for external querying
        public MySqlConnection MyConnection { get; private set; }

        protected const string SET_UTC = "set time_zone='+00:00';\r\n";

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
                MyConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, MyConnection);
                adapter.Fill(dataSet);
            }
            finally
            {
                MyConnection.Close();
            }

            return dataSet;
        }

        public DataTable SelectDataAsDataTable(string mySelectQuery)
        {
            return SelectDataAsDataTable(mySelectQuery, 0);
        }

        /// <summary>
        ///     retreives
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <param name="timeout"></param>
        /// <returns></returns>
        public DataTable SelectDataAsDataTable(string mySelectQuery, int timeout)
        {
            var dataTable = new DataTable();
            dataTable.Clear();
            try
            {
                MyConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, MyConnection, timeout);
                adapter.Fill(dataTable);
            }
            finally
            {
                MyConnection.Close();
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
                MyConnection.Open();
                var adapter = new MySqlDataAdapter();
                SetSelectCommandAndOutputToConsole(mySelectQuery, adapter, MyConnection);
                adapter.Fill(dataTable);
            }
            finally
            {
                MyConnection.Close();
            }

            return dataTable.AsDataView();
        }

        /// <summary>
        ///     TODO replace with Log4Net logging
        /// </summary>
        /// <param name="mySelectQuery"></param>
        /// <param name="adapter"></param>
        /// <param name="myConnection"></param>
        /// <param name="timeout"></param>
        [SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities",
            Justification =
                "It is safe to suppress a warning from this rule if the command text does not contain any user input.")]
        private static void SetSelectCommandAndOutputToConsole(string mySelectQuery, MySqlDataAdapter adapter,
            MySqlConnection myConnection, int timeout = 0)
        {
            Console.WriteLine("executing query: \r\n {0}", mySelectQuery);
            adapter.SelectCommand = timeout != 0
                ? new MySqlCommand(mySelectQuery, myConnection) {CommandTimeout = timeout}
                : new MySqlCommand(mySelectQuery, myConnection);
        }
    }
}