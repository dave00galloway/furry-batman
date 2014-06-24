using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts
{
    public class CnxTradeTableDataContext : MySqlDataContextSubstitute
    {
        public const string TRADE = "TRADE";

        public CnxTradeTableDataContext(string connectionString) : base(connectionString)
        {
        }
    }
}