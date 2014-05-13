using System;
using System.Globalization;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.TypedDataTables;

namespace qdf.AcceptanceTests.DataContexts
{
    public class CcToolDataContext : MySqlDataContextSubstitute
    {
        public const string Cc = "CC";

        public CcToolDataContext(string connectionString)
            : base(connectionString)
        {
        }

        /// <summary>
        ///     Create the query string used by CC Tool
        /// </summary>
        /// <param name="start">start cc_tbl_snapshot.UpdateDateTime</param>
        /// <param name="end">end cc_tbl_snapshot.UpdateDateTime</param>
        /// <returns></returns>
        public static string CcToolQuery(DateTime start, DateTime end)
        {
            return String.Format(
                "	SELECT	" +
                "     ctps.Name AS Section," +
                "	  srv.Name AS ServerName,	" +
                "	  cr.SymbolCode,	" +
                "	  cr.IsBookA,	" +
                "	  cr.BidPrice,	" +
                "	  cr.AskPrice,	" +
                "	  p.Volume AS Volume,	" +
                "	  smb.EffectiveContractSize AS ContractSize,	" +
                "	  s.UpdateDateTime	" +
                "	FROM cc_tbl_snapshot s	" +
                "	  INNER JOIN cc_tbl_snapshot_currency_rate cr	" +
                "	    ON s.Id = cr.SnapshotId	" +
                "	  INNER JOIN cc_tbl_snapshot_postition p	" +
                "	    ON cr.Id = p.SnapshotCurrencyRateId	" +
                "	  INNER JOIN cc_tbl_server AS srv	" +
                "	    ON p.ServerId = srv.Id	" +
                "	  INNER JOIN cc_tbl_symbol AS smb	" +
                "	    ON cr.SymbolCode = smb.Code AND smb.IsSpreadBetting = 0	" +
                "     INNER JOIN cc_tbl_position_section AS ctps " +
                "       ON p.SectionId = ctps.Id" +
                "	WHERE s.UpdateDateTime BETWEEN '{0}' AND '{1}' 	" +
                "	ORDER BY s.UpdateDateTime DESC, ServerName, cr.SymbolCode",
                start.ToString(DateTimeUtils.MySqlDateFormatToSeconds),
                end.ToString(DateTimeUtils.MySqlDateFormatToSeconds));
        }

        public static string cc_tbl_position_section()
        {
            return String.Format("SELECT * FROM cc_tbl_position_section");
        }

        /// <summary>
        /// return the snapshot time closest to midday on the specified date
        /// </summary>
        /// <param name="snapshotDate"></param>
        /// <returns></returns>
        public static string CcDailySnapshotTimeQuery(DateTime snapshotDate)
        {
            return string.Format(
                "SELECT " +
                "s.UpdateDateTime " +
                "FROM cc.cc_tbl_snapshot s " +
                "WHERE s.UpdateDateTime BETWEEN STR_TO_DATE('{0}-{1}-{2} 11:59:00', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('{0}-{1}-{2} 12:59:00', '%Y-%m-%d %H:%i:%s') " +
                "ORDER BY ABS(STR_TO_DATE('{0}-{1}-{2} 12:00:00', '%Y-%m-%d %H:%i:%s') - s.UpdateDateTime) LIMIT 1;", snapshotDate.Year.ToString(CultureInfo.InvariantCulture), snapshotDate.Month.PadZeros(2), snapshotDate.Day.PadZeros(2));
            //SELECT
            //  s.UpdateDateTime
            //FROM cc.cc_tbl_snapshot s
            //  WHERE s.UpdateDateTime BETWEEN STR_TO_DATE('2014-04-19 11:59:00', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('2014-04-19 12:59:00', '%Y-%m-%d %H:%i:%s')
            //ORDER BY ABS(STR_TO_DATE('2014-05-10 12:00:00', '%Y-%m-%d %H:%i:%s') - s.UpdateDateTime) LIMIT 1;
        }

        /// <summary>
        ///     Demo method to calculate spread for a server/symbol/time and also to show benefit of using strongly typed data
        ///     tables
        /// </summary>
        /// <param name="ccToolDataTable"></param>
        public static void OutputCalculatedSpread(CcToolDataTable ccToolDataTable)
        {
            var typedTableResult = ccToolDataTable.Rows.Cast<CCtoolRow>().Select(myRow => new
            {
                Server = myRow.ServerName,
                Spread = (myRow.BidPrice - myRow.AskPrice).ToString(CultureInfo.InvariantCulture),
                Time = myRow.UpdateDateTime.ToString(CultureInfo.InvariantCulture)
            });

            foreach (var item in typedTableResult)
            {
                Console.WriteLine("using typedTableResult, Server Name was {0}, spread was {1} at {2}", item.Server,
                    item.Spread, item.Time);
            }
        }
    }
}