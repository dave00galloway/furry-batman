using System;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts
{
    public class CnxTradeTableDataContext : MySqlDataContextSubstitute
    {
        public const string TRADE = "TRADE";

        private static readonly string TradeQueryByIdString =
            TradeQuery +
            "   trade_id ";

        private const string TradeQuery =
            "SELECT " +
            "   security_id, price, spotrate, spotratehubtomaker, amountccy1, amountccy2, " +
            "   side, order_id, login, trade_id, linked_trade_id, transact_time, trade_date, " +
            "   settl_date, party_1_role, party_1_name, party_2_role, party_2_name, comment, " +
            "   server_id, giveup_status, book, hub, client_order_id,  traded_ccy, counter_ccy, " +
            "   aggressor, (trade_type+0) AS trade_type, forward_points, swap_points, far_amountccy1, " +
            "   far_amountccy2, far_settl_date, trade_report_id, reconcil_status, id " +
            "FROM " +
            "   auktest_hedge.trade " +
            "WHERE ";

        private const string SetUtc = "set time_zone='+00:00';\r\n";

        public CnxTradeTableDataContext(string connectionString) : base(connectionString)
        {
        }

        public static string QuerySingleTrade(string tradeId)
        {
            //return String.Format("SELECT * FROM auktest_hedge.trade WHERE trade_id = '{0}'", tradeId);
            return
                String.Format("{0}{1} = '{2}'",SetUtc,
                    TradeQueryByIdString,
                    tradeId);
        }

        public static string QueryTradesById(string idsAsList)
        {
            //return String.Format("SELECT * FROM auktest_hedge.trade WHERE trade_id in {0}", idsAsList);
            return
                String.Format("{0}{1} in {2}",SetUtc,
                    TradeQueryByIdString,
                    idsAsList);
        }

        public static string QueryTradesByDateTime(DateTime from, DateTime to)
        {
            return
                String.Format("{0}{1} (transact_time >= '{2}' AND transact_time <= '{3}')", SetUtc,
                    TradeQuery, from.ConvertDateTimeToMySqlDateFormatToSeconds(), to.ConvertDateTimeToMySqlDateFormatToSeconds());
        }
    }
}