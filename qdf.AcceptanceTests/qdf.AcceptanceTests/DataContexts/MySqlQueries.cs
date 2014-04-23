using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// Class holding queries to be executed against MySql databases
    /// </summary>
    public static class MySqlQueries
    {
        /// <summary>
        /// use this where MySql expects date time in the format yyyy-MM-dd H:mm:ss e.g. 2014-04-17 10:47:34
        /// </summary>
        public static readonly string MySqlDateFormatToSeconds = "yyyy-MM-dd H:mm:ss";

        /// <summary>
        /// Create the query string used by CC Tool
        /// </summary>
        /// <param name="start">start cc_tbl_snapshot.UpdateDateTime</param>
        /// <param name="end">end cc_tbl_snapshot.UpdateDateTime</param>
        /// <returns></returns>
        public static string CCToolQuery(DateTime start, DateTime end)
        {
            return String.Format(
            "	SELECT	" +
            "     ctps.Name AS Section,"+
            "	  srv.Name AS ServerName,	" +
            "	  srv.PlatformId,	" +
            "	  srv.Id,	" +
            "	  srv.DatabaseName,	" +
            "	  cr.SymbolCode,	" +
            "	  cr.IsBookA,	" +
            "	  cr.BidPrice,	" +
            "	  cr.AskPrice,	" +
            "	  p.Volume AS Volume,	" +
            "	  smb.EffectiveContractSize AS ContractSize,	" +
            "	  s.UpdateDateTime	" +
            "	FROM cc.cc_tbl_snapshot s	" +
            "	  INNER JOIN cc_tbl_snapshot_currency_rate cr	" +
            "	    ON s.Id = cr.SnapshotId	" +
            "	  INNER JOIN cc_tbl_snapshot_postition p	" +
            "	    ON cr.Id = p.SnapshotCurrencyRateId	" +
            "	  INNER JOIN cc_tbl_server AS srv	" +
            "	    ON p.ServerId = srv.Id	" +
            "	  INNER JOIN cc.cc_tbl_symbol AS smb	" +
            "	    ON cr.SymbolCode = smb.Code AND smb.IsSpreadBetting = 0	" +
            "     INNER JOIN cc.cc_tbl_position_section AS ctps "+
            "       ON p.SectionId = ctps.Id" +
            "	WHERE s.UpdateDateTime BETWEEN '{0}' AND '{1}' 	" +
            "	ORDER BY s.UpdateDateTime DESC, ServerName, cr.SymbolCode", start.ToString(MySqlDateFormatToSeconds), end.ToString(MySqlDateFormatToSeconds));

        }
    }
}
