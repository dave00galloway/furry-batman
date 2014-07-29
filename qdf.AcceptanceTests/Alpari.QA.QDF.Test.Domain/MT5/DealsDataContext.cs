using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;

namespace Alpari.QA.QDF.Test.Domain.MT5
{
    public class DealsDataContext : MySqlDataContextSubstitute
    {
        public DealsDataContext(string connectionString) : base(connectionString)
        {
        }

        public static string HighestDealForLogin(long login)
        {
            return string.Format("SELECT MAX(deal) AS deal FROM ars_test_mt5_uat.deals WHERE login = {0};", login);
        }
    }
}
