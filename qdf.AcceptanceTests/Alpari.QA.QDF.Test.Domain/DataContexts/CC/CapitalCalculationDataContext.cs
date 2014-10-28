using System;
using System.Collections.Generic;
using System.Data;
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
                try
                {
                    DataTable result = SelectDataAsDataTable(GetPositionsQueryString(ccParameters), 0,
                        ccParameters.QueryDateTime == ccParameters.StartTime);
                    if (result != null)
                        retval.Add(new SnapshotComparison
                        {
                            Server1Name = ccParameters.Database1,
                            Server1Volume = (decimal) result.Rows[0]["database1_volume"],
                            Server2Name = ccParameters.Database2,
                            Server2Volume = (decimal) result.Rows[0]["database2_volume"],
                            SnapshotTimeToMinute = (string) result.Rows[0]["snapshot_time_to_minute"],
                            Diff = CalculateDiff(result),
                        });
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                ccParameters.QueryDateTime = ccParameters.QueryDateTime.AddMinutes(1);
            }
            CalculateDeltas(retval);
            return retval;
        }

        public IList<SnapshotComparison> GetRedisAndArsPositionSnapshots(
            CapitalCalculationSnapshotParameters ccParameters)
        {
            IList<SnapshotComparison> retval = new List<SnapshotComparison>();
            ccParameters.QueryDateTime = ccParameters.StartTime;

            while (ccParameters.QueryDateTime <= ccParameters.EndTime)
            {
                DataTable result;
                try
                {
                    result = SelectDataAsDataTable(GetRedisAndArsPositionsQueryString(ccParameters), 0,
                        ccParameters.QueryDateTime == ccParameters.StartTime);
                    if (result != null)
                        retval.Add(new SnapshotComparison
                        {
                            Server1Name = ccParameters.Server1,
                            Server1Volume = (decimal) result.Rows[0]["database1_volume"],
                            Server2Name = ccParameters.Server2,
                            Server2Volume = (decimal) result.Rows[0]["database2_volume"],
                            SnapshotTimeToMinute = (string) result.Rows[0]["snapshot_time_to_minute"],
                            Diff = CalculateDiff(result),
                        });
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                ccParameters.QueryDateTime = ccParameters.QueryDateTime.AddMinutes(1);
            }
            CalculateDeltas(retval);
            return retval;
        }


        private static decimal CalculateDiff(DataTable result)
        {
            return (decimal) result.Rows[0]["database1_volume"] -
                   (decimal) result.Rows[0]["database2_volume"];
        }

        public static void CalculateDeltas(IList<SnapshotComparison> retval)
        {
            for (int index = 0; index < retval.Count; index++)
            {
                SnapshotComparison snapshotComparison = retval[index];
                if (index > 0)
                {
                    snapshotComparison.Delta = retval[index - 1].Diff - snapshotComparison.Diff;
                }
            }
        }

        public static void CalculateDiffs(IEnumerable<SnapshotComparison> list)
        {
            foreach (SnapshotComparison snapshotComparison in list)
            {
                snapshotComparison.Diff = snapshotComparison.Server1Volume - snapshotComparison.Server2Volume;
            }
        }

        /// <summary>
        ///     get a single set of position snapshots and return as datatable
        /// </summary>
        /// <param name="ccParameters"></param>
        /// <param name="connectionName"></param>
        /// <returns></returns>
        public DataTable GetPositionSnapshots(CapitalCalculationSnapshotParameters ccParameters, string connectionName)
        {
            var result = new DataTable(connectionName);
            result.Columns.Add("snapshot_time_to_minute", typeof (string));
            result.Columns.Add("database1_volume", typeof (decimal));
            result.PrimaryKey = new[] {result.Columns["snapshot_time_to_minute"]};
            ccParameters.QueryDateTime = ccParameters.StartTime;
            while (ccParameters.QueryDateTime <= ccParameters.EndTime)
            {
                try
                {
                    result.ImportRow(SelectDataAsDataTable(GetSinglePositionQueryString(ccParameters)).Rows[0]);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
                ccParameters.QueryDateTime = ccParameters.QueryDateTime.AddMinutes(1);
            }
            return result;
        }

        private static string GetSinglePositionQueryString(CapitalCalculationSnapshotParameters ccParameters)
        {
            return String.Format(
                "SET time_zone = '+00:00';" +
                "SET @time = STR_TO_DATE('{0}', '%Y-%m-%d %H:%i');" +
                "SET @Book = {1};" +
                "SET @Server = '{2}';" +
                "SET @SymbolCode = '{3}';" +
                "SET @Section = '{4}';" +
                "USE {5};" +
                "SET @database1 = (SELECT" +
                "    cc.Volume" +
                "  FROM (SELECT" +
                "      p.Volume" +
                "    FROM cc_tbl_snapshot_postition p" +
                "      JOIN cc_tbl_snapshot_currency_rate cr" +
                "        ON p.SnapshotCurrencyRateId = cr.Id" +
                "      JOIN (SELECT" +
                "          cts.Id AS last_snapshot_id," +
                "          cts.UpdateDateTime AS last_snapshot_time" +
                "        FROM cc_tbl_snapshot cts" +
                "        WHERE cts.UpdateDateTime < @time" +
                "        ORDER BY cts.UpdateDateTime DESC LIMIT 1) AS t" +
                "        ON cr.SnapshotId = t.last_snapshot_id" +
                "      JOIN cc_tbl_server cts" +
                "        ON p.ServerId = cts.Id" +
                "      JOIN alpari_general.ag_tbl_position_section atps" +
                "        ON p.SectionId = atps.Id" +
                "    WHERE cts.Name = @Server AND cr.SymbolCode = @SymbolCode AND cr.IsBookA = @Book AND atps.Name = @Section" +
                "    ORDER BY p.Id DESC) cc);" +
                "SELECT" +
                "  COALESCE(@time,'') AS snapshot_time_to_minute," +
                "  COALESCE(@database1,0) AS database1_volume"
                , ccParameters.QueryDateTime.ConvertDateTimeToMySqlDateFormatToSeconds(),
                ccParameters.Book == "B" ? 0 : 1,
                ccParameters.Server, ccParameters.Symbol, ccParameters.Section, ccParameters.Database1
                );
        }

        //public Dictionary<string, decimal> GetPositionSnapshotsAsDict(CapitalCalculationSnapshotParameters ccParameter)
        //{
        //    var retval = new Dictionary<string, decimal>();
        //    DataTable result = new DataTable(ccParameter.);

        //    return retval;
        //}

        private static string GetRedisAndArsPositionsQueryString(CapitalCalculationSnapshotParameters ccParameters)
        {
            return String.Format(
                " SET @time = STR_TO_DATE('{0}', '%Y-%m-%d %H:%i'); " +
                " SET @Book = {1}; " +
                " SET @Server1 = '{2}'; " +
                " SET @Server2 = '{3}'; " +
                " SET @SymbolCode = '{4}'; " +
                " SET @Section = '{5}'; " +
                " USE {6}; " +
                " SET @database1 = (SELECT " +
                "     qacc.Volume " +
                "   FROM (SELECT " +
                "       p.Volume " +
                "     FROM cc_tbl_snapshot_postition p " +
                "       JOIN cc_tbl_snapshot_currency_rate cr " +
                "         ON p.SnapshotCurrencyRateId = cr.Id " +
                "       JOIN (SELECT " +
                "           cts.Id AS last_snapshot_id, " +
                "           cts.UpdateDateTime AS last_snapshot_time " +
                "         FROM cc_tbl_snapshot cts " +
                "         WHERE cts.UpdateDateTime < @time " +
                "         ORDER BY cts.UpdateDateTime DESC LIMIT 1) AS t " +
                "         ON cr.SnapshotId = t.last_snapshot_id " +
                "       JOIN cc_tbl_server cts " +
                "         ON p.ServerId = cts.Id " +
                "       JOIN alpari_general.ag_tbl_position_section atps " +
                "         ON p.SectionId = atps.Id " +
                "     WHERE cts.Name = @Server1 AND cr.SymbolCode = @SymbolCode AND cr.IsBookA = @Book AND atps.Name = @Section " +
                "     ORDER BY p.Id DESC) qacc); " +
                " SET @database2 = (SELECT " +
                "     uatcc.Volume " +
                "   FROM (SELECT " +
                "       p.Volume " +
                "     FROM cc_tbl_snapshot_postition p " +
                "       JOIN cc_tbl_snapshot_currency_rate cr " +
                "         ON p.SnapshotCurrencyRateId = cr.Id " +
                "       JOIN (SELECT " +
                "           cts.Id AS last_snapshot_id, " +
                "           cts.UpdateDateTime AS last_snapshot_time " +
                "         FROM cc_tbl_snapshot cts " +
                "         WHERE cts.UpdateDateTime < @time " +
                "         ORDER BY cts.UpdateDateTime DESC LIMIT 1) AS t " +
                "         ON cr.SnapshotId = t.last_snapshot_id " +
                "       JOIN cc_tbl_server cts " +
                "         ON p.ServerId = cts.Id " +
                "       JOIN alpari_general.ag_tbl_position_section atps " +
                "         ON p.SectionId = atps.Id " +
                "     WHERE cts.Name = @Server2 AND cr.SymbolCode = @SymbolCode AND cr.IsBookA = @Book AND atps.Name = @Section " +
                "     ORDER BY p.Id DESC) uatcc); " +
                " SELECT " +
                "   COALESCE(@time,'') AS snapshot_time_to_minute, " +
                "   COALESCE(@database1,0) AS database1_volume, " +
                "   COALESCE(@database2,0) AS database2_volume "
                , ccParameters.QueryDateTime.ConvertDateTimeToMySqlDateFormatToSeconds(),
                ccParameters.Book == "B" ? 0 : 1,
                ccParameters.Server1, ccParameters.Server2,
                ccParameters.Symbol, ccParameters.Section, ccParameters.Database1
                );
        }

        private static string GetPositionsQueryString(
            CapitalCalculationSnapshotParameters ccParameters)
        {
            string database1 = ccParameters.Database1;
            string database2 = ccParameters.Database2;
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
                ccParameters.QueryDateTime.ConvertDateTimeToMySqlDateFormatToSeconds(),
                ccParameters.Book == "B" ? 0 : 1,
                ccParameters.Server, ccParameters.Symbol,
                ccParameters.Section);
        }
    }
}