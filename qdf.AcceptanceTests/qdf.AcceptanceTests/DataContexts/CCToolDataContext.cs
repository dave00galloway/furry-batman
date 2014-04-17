using qdf.AcceptanceTests.TypedDataTables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.DataContexts
{
    public class CCToolDataContext : MySqlDataContextSubstitute
    {
        public CCToolDataContext(string connectionString)
            : base(connectionString)
        {

        }

        /// <summary>
        /// Demo method to calculate spread for a server/symbol/time and also to show benefit of using strongly typed data tables
        /// </summary>
        /// <param name="ccToolData"></param>
        public static void OutputCalculatedSpread(CCToolData ccToolData)
        {
            var typedTableResult = from CCtoolRow myRow in ccToolData.Rows
                                   select new
                                   {
                                       Server = myRow.ServerName,
                                       Spread = (myRow.BidPrice - myRow.AskPrice).ToString(),
                                       Time = myRow.UpdateDateTime.ToString()
                                   };

            foreach (var item in typedTableResult)
            {
                Console.WriteLine(string.Format("using typedTableResult, Server Name was {0}, spread was {1} at {2}", item.Server, item.Spread,item.Time));
            }

            //non-typed data table - doesn't break if the data definition changes - dangerous!
            //var tableResult = from DataRow myRow in ccEntries.Rows
            //                  where myRow.Field<string>("DatabaseName").StartsWith("ars_")
            //                  select new
            //                  {
            //                      Server = myRow.Field<string>("DatabaseName"),
            //                      Spread = (myRow.Field<decimal>("BidPrice") - myRow.Field<decimal>("AskPrice"))
            //                  };

            //foreach (var item in tableResult)
            //{
            //    Console.WriteLine(string.Format("using table, Server Name is {0}, spread is {1}", item.Server, item.Spread.ToString()));
            //}
        }
    }
}
