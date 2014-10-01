using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.CC
{
    public class CapitalCalculationDataContext : MySqlDataContextSubstitute
    {
        public CapitalCalculationDataContext(string connectionString) : base(connectionString)
        {
        }

        public IList<SnapshotComparison> GetPositionSnapshots(CapitalCalculationSnapshotParameters ccParameters)
        {
            IList<SnapshotComparison> retval = new List<SnapshotComparison>();
            ccParameters.QueryDateTime = ccParameters.StartTime;

            while (ccParameters.QueryDateTime <= ccParameters.EndTime)
            {
                DataTable result;
                try
                {
                    result = SelectDataAsDataTable(GetPositionsQueryString(ccParameters), 0, ccParameters.QueryDateTime == ccParameters.StartTime);
                    if (result != null)
                        retval.Add(new SnapshotComparison
                        {
                            Server1Name = ccParameters.Database1,
                            Server1Volume = (decimal)result.Rows[0]["database1_volume"],
                            Server2Name = ccParameters.Database2,
                            Server2Volume = (decimal)result.Rows[0]["database2_volume"],
                            SnapshotTimeToMinute = (string)result.Rows[0]["snapshot_time_to_minute"]
                        });
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                ccParameters.QueryDateTime = ccParameters.QueryDateTime.AddMinutes(1);
            }

            return retval;
        }

        private static string GetPositionsQueryString(
            CapitalCalculationSnapshotParameters capitalCalculationSnapshotParameters)
        {
            var database1 = capitalCalculationSnapshotParameters.Database1;
            var database2 = capitalCalculationSnapshotParameters.Database2;
            return String.Format(
                " SET time_zone = '+00:00';" +
                " SET @time = STR_TO_DATE('{0}', '%Y-%m-%d %H:%i');" +
                " SET @Book = {1};" +
                " SET @Server = '{2}';" +
                " SET @SymbolCode = '{3}';" +
                " SET @Section = '{4}';" +
                " " +
                string.Format(" USE {0};", database1) +
                " SET @database1 = (" +
                " SELECT" +
                "   qacc.Volume" +
                " FROM (SELECT" +
                "     p.Volume" +
                "   FROM cc_tbl_snapshot_postition p" +
                "     JOIN cc_tbl_snapshot_currency_rate cr" +
                "       ON p.SnapshotCurrencyRateId = cr.Id" +
                "     JOIN (SELECT" +
                "         cts.Id AS last_snapshot_id," +
                "         cts.UpdateDateTime AS last_snapshot_time" +
                "       FROM cc_tbl_snapshot cts" +
                "       WHERE cts.UpdateDateTime < @time" +
                "       ORDER BY cts.UpdateDateTime DESC" +
                "       LIMIT 1) AS t" +
                "       ON cr.SnapshotId = t.last_snapshot_id" +
                "     JOIN cc_tbl_server cts" +
                "       ON p.ServerId = cts.Id" +
                "     JOIN alpari_general.ag_tbl_position_section atps" +
                "       ON p.SectionId = atps.Id" +
                "   WHERE cts.Name = @Server" +
                "   AND cr.SymbolCode = @SymbolCode" +
                "   AND cr.IsBookA = @Book" +
                "   AND atps.Name = @Section" +
                " " +
                "   ORDER BY p.Id DESC) qacc);" +
                " " +
                string.Format(" USE {0};", database2) +
                " SET @database2 = (" +
                " " +
                " SELECT" +
                "   uatcc.Volume" +
                " FROM (SELECT" +
                "     p.Volume" +
                "   FROM cc_tbl_snapshot_postition p" +
                "     JOIN cc_tbl_snapshot_currency_rate cr" +
                "       ON p.SnapshotCurrencyRateId = cr.Id" +
                "     JOIN (SELECT" +
                "         cts.Id AS last_snapshot_id," +
                "         cts.UpdateDateTime AS last_snapshot_time" +
                "       FROM cc_tbl_snapshot cts" +
                "       WHERE cts.UpdateDateTime < @time" +
                "       ORDER BY cts.UpdateDateTime DESC" +
                "       LIMIT 1) AS t" +
                "       ON cr.SnapshotId = t.last_snapshot_id" +
                "     JOIN cc_tbl_server cts" +
                "       ON p.ServerId = cts.Id" +
                "     JOIN alpari_general.ag_tbl_position_section atps" +
                "       ON p.SectionId = atps.Id" +
                "   WHERE cts.Name = @Server" +
                "   AND cr.SymbolCode = @SymbolCode" +
                "   AND cr.IsBookA = @Book" +
                "   AND atps.Name = @Section" +
                " " +
                "   ORDER BY p.Id DESC) uatcc);" +
                " SELECT " +
                "   COALESCE(@time,'') AS snapshot_time_to_minute, " +
                "   COALESCE(@database1,0) AS database1_volume, " +
                "   COALESCE(@database2,0) AS database2_volume",
                capitalCalculationSnapshotParameters.QueryDateTime.ConvertDateTimeToMySqlDateFormatToSeconds(), 
                capitalCalculationSnapshotParameters.Book == "B" ? 0 : 1,
                capitalCalculationSnapshotParameters.Server, capitalCalculationSnapshotParameters.Symbol,
                capitalCalculationSnapshotParameters.Section);
        }
    }
}