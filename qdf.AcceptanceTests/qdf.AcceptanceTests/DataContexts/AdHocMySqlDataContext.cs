using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.DataContexts
{
    public class AdHocMySqlDataContext : MySqlDataContextSubstitute
    {
        public AdHocMySqlDataContext(string connectionString)
            : base(connectionString)
        {

        }
    }
}
