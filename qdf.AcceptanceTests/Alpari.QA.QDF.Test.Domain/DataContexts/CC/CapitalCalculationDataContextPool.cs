using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.CC
{
    /// <summary>
    ///     Class allowing access to multiple cc instances using different connection strings
    /// </summary>
    public class CapitalCalculationDataContextPool
    {
        private CapitalCalculationDataContextPoolParams _capitalCalculationDataContextPoolParams;

        public CapitalCalculationDataContextPool(
            IDictionary<string, CapitalCalculationDataContext> capitalCalculationDataContexts)
        {
            CapitalCalculationDataContexts = capitalCalculationDataContexts;
        }

        public IDictionary<string, CapitalCalculationDataContext> CapitalCalculationDataContexts { get; set; }

        public CapitalCalculationDataContextPoolParams CapitalCalculationDataContextPoolParams
        {
            get { return _capitalCalculationDataContextPoolParams; }
            set
            {
                _capitalCalculationDataContextPoolParams = value;
                CapitalCalculationDataContexts.Add(value.Connection1, new CapitalCalculationDataContext(
                    ConfigurationManager.ConnectionStrings[value.Connection1].ConnectionString
                        .UnProtect('_')));
                CapitalCalculationDataContexts.Add(value.Connection2, new CapitalCalculationDataContext(
                    ConfigurationManager.ConnectionStrings[value.Connection2].ConnectionString
                        .UnProtect('_')));
            }
        }

        public IList<SnapshotComparison> GetRedisAndArsPositionSnapshots(
            CapitalCalculationSnapshotParameters ccParameter)
        {
            DataTable dict1 = null;
            DataTable dict2 = null;
            Task task1 = Task.Factory.StartNew(() => dict1 =
                CapitalCalculationDataContexts[CapitalCalculationDataContexts.Keys.First()].GetPositionSnapshots
                    (
                        new CapitalCalculationSnapshotParameters
                        {
                            Book = ccParameter.Book,
                            Database1 = ccParameter.Database1,
                            EndTime = ccParameter.EndTime,
                            Section = ccParameter.Section,
                            Server = ccParameter.Server1,
                            StartTime = ccParameter.StartTime,
                            Symbol = ccParameter.Symbol
                        }, "Connection1"));
            Task task2 = Task.Factory.StartNew(() =>
                dict2 = CapitalCalculationDataContexts[CapitalCalculationDataContexts.Keys.Last()].GetPositionSnapshots(
                    new CapitalCalculationSnapshotParameters
                    {
                        Book = ccParameter.Book,
                        Database1 = ccParameter.Database2,
                        EndTime = ccParameter.EndTime,
                        Section = ccParameter.Section,
                        Server = ccParameter.Server2,
                        StartTime = ccParameter.StartTime,
                        Symbol = ccParameter.Symbol
                    }, "Connection2")
                );
            Task.WaitAll(task1, task2);

            List<SnapshotComparison> list = dict1.Rows.Cast<DataRow>().Select(row =>
                new SnapshotComparison
                {
                    SnapshotTimeToMinute = row["snapshot_time_to_minute"] as string,
                    Server1Name = ccParameter.Server1,
                    Server1Volume = (decimal) row["database1_volume"],
                    Server2Name = ccParameter.Server2,
                    Server2Volume = (decimal) (dict2.Rows.Find(row["snapshot_time_to_minute"])["database1_volume"] ?? 0)
                }).ToList();
            //check there aren't any extra rows in dict 2
            foreach (DataRow row in dict2.Rows.Cast<DataRow>()
                .Where(row => !list.Any(x => Equals(x.SnapshotTimeToMinute, row["snapshot_time_to_minute"]))))
            {
                list.Add(new SnapshotComparison
                {
                    SnapshotTimeToMinute = row["snapshot_time_to_minute"] as string,
                    Server1Name = ccParameter.Server1,
                    Server1Volume = 0,
                    Server2Name = ccParameter.Server2,
                    Server2Volume = (decimal) row["database1_volume"]
                });
            }
            list.Sort((x, snapshotComparison) =>
            {
                //TODO:- sort out SnapshotComparison so that the type of snapshot time is a DateTime, thus avoiding part of the proceeding complexity
                DateTime date1 = DateTime.ParseExact(x.SnapshotTimeToMinute, DateTimeUtils.MY_SQL_DATE_FORMAT_TO_SECONDS,
                    CultureInfo.InvariantCulture);
                DateTime date2 = DateTime.ParseExact(snapshotComparison.SnapshotTimeToMinute,
                    DateTimeUtils.MY_SQL_DATE_FORMAT_TO_SECONDS, CultureInfo.InvariantCulture);
                if (DateTime.Compare(date1, date2) < 0)
                {
                    return -1;
                }
                return 1;
            });
            CapitalCalculationDataContext.CalculateDiffs(list);
            CapitalCalculationDataContext.CalculateDeltas(list);
            return list;
        }
    }

    public class CapitalCalculationDataContextPoolParams
    {
        public string Connection1 { get; set; }
        public string Connection2 { get; set; }
    }
}