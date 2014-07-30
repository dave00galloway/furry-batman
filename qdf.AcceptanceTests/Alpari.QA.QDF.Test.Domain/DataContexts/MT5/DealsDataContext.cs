using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.MT5
{
    public class DealsDataContext : MySqlDataContextSubstitute
    {
        private const string Deals = "deals";
        public string DealTable { get; set; }
        public DealsDataContext(string connectionString, string dealTable) : base(connectionString)
        {
            DealTable = string.Format("{0}.{1}", dealTable, Deals);
        }

        public string HighestDealForLogin(ulong login)
        {
            return string.Format("SELECT MAX(deal) AS deal FROM {1} WHERE login = {0};", login, DealTable);
        }

        public string NewDealsQuery(ulong login, ulong prevHighestDeal)
        {
            return string.Format(
                "SELECT deal, " + // -- needed for debug
                "        login, " + //-- needed for debug" +
                "       `order`, " + // -- needed for debug" +
                "       action, " + // -- side, make sure filtering on 0 and 1 as actions other than Buy & Sell are included (e.g. Deposit & Withdrawal)" +
                "        from_unixtime(time) as timestamp,  " + //-- needed" +
                "       symbol,  " + //-- TEMnemonic" +
                "       price,  " + //-- price" +
                "       volume,  " + //-- FillVolume" +
                "       comment  " + //-- needed" +
                "FROM {2}" +
                "  WHERE login = {0}" +
                "  AND deal > {1}" +
                "  AND ACTION < 2;     ", login, prevHighestDeal, DealTable);
        }
    }
}
