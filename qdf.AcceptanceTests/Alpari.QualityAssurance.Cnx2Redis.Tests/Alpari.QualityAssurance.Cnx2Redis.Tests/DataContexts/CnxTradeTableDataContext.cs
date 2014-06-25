using System;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts
{
    public class CnxTradeTableDataContext : MySqlDataContextSubstitute
    {
        public const string TRADE = "TRADE";

        public CnxTradeTableDataContext(string connectionString) : base(connectionString)
        {
        }

        public static string QuerySingleTrade(string tradeId)
        {
            return String.Format("SELECT * FROM auktest_hedge.trade WHERE trade_id = '{0}'", tradeId);
        }

        public static string QueryTradesById(string idsAsList)
        {
            return String.Format("SELECT * FROM auktest_hedge.trade WHERE trade_id in {0}", idsAsList);
        }
    }
}