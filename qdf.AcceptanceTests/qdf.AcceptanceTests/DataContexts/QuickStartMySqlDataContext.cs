//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using ALinq;
//using MySql.Data.MySqlClient;


//namespace qdf.AcceptanceTests.DataContexts
//{
//    /// <summary>
//    /// not a true data context, just the one that's provided in 
//    /// http://www.alinq.org/Document/Document.aspx?element=T%3AQuick_Start
//    /// adapted for MySql
//    /// {"Found license fail!"}
//    /// </summary>
//    public class QuickStartMySqlDataContext
//    {
//        public QuickStartMySqlDataContext()
//        {
//            var builder = new MySqlConnectionStringBuilder()
//            {
//                Server = "10.25.9.213",
//                Port = 3306,
//                UserID = "ars",
//                Password = "1q2w3e",
//                Database = "cc"
//            };
//            var conn = new MySqlConnection(builder.ToString());
//            var context = new ALinq.DataContext(conn,
//                                        typeof(ALinq.MySQL.MySqlProvider));
//        }
//    }
//}

