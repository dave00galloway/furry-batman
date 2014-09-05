using System.Data;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.MT4
{
    public class PositionsDataContext : MySqlDataContextSubstitute
    {
        public PositionsDataContext(string connectionString)
            : base(connectionString)
        {
        }

        public PositionsDataContext(string connectionString, string dataBaseName) : base(connectionString)
        {
            DataBaseName = dataBaseName;
        }

        public string DataBaseName { private get; set; }

        public DataTable GetOpenPositionsFromDate(string earliestPositionDate)
        {
            return SelectDataAsDataTable(GetOpenPositionsFromDateQuery(DataBaseName, earliestPositionDate));
        }

        private static string GetOpenPositionsFromDateQuery(string dataBaseName, string earliestPositionDate)
        {
            return string.Format(
                "USE {0};" +
                "SELECT " +
                "o.login," +
                "o.`order`, " +
                " o.cmd," +
                "(o.volume / 100) AS volume, " +
                "o.open_price As OpenPrice," +
                "o.sl," +
                " o.tp," +
                "FROM_UNIXTIME(o.open_ts) AS OpenTime," +
                " o.comment," +
                "FROM_UNIXTIME(t.ts) AS timestamp, " + //"-- for info only, should always be later than redis timestamp" +
                "a.`group`, " +
                "CAST(o.state AS CHAR) AS status, " +
                "o.symbol_name AS symbol, " +
                "\"ProTest\" AS server, " +
                "\"UNKNOWN\" AS book " +
                "FROM orders o " +
                "JOIN accounts a " +
                "ON  o.login = a.login " +
                "LEFT JOIN traderecord t " +
                "ON o.`order` = t.`order` " +
                "WHERE " +
                "o.cmd IN (0,1)" +
                "AND FROM_UNIXTIME(o.open_ts) >= STR_TO_DATE('{1}', '%Y-%m-%d')" +
                "and o.close_ts = 0 " + //"-- open orders" +
                "and a.`status` NOT LIKE '%RE%'" +
                "and a.`group` not rlike '^Closed.*IB$|demo|test'" +
                "and a.`name` not rlike 'Test|Data Center|Data Centre'" +
                "and a.email not like '%alpari.co.uk'" +
                "AND t.ts = (SELECT MAX(ts) FROM traderecord t2 WHERE t.`order` = t2.`order`)",
                dataBaseName,
                earliestPositionDate);
        }
    }
}