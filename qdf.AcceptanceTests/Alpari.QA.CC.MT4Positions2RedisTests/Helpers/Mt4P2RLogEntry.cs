using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Windows.Forms.DataVisualization.Charting;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4P2RLogEntry
    {
        private string _date;
        private string _time;

        public string Date
        {
            set { _date = value; }
        }

        public string Time
        {
            set { _time = value; }
        }

        public TimeStamp TimeStamp
        {
            get
            {
                DateTime date = Convert.ToDateTime(_date);
                DateTime time = Convert.ToDateTime(_time);
                return new TimeStamp(date.Add(time.TimeOfDay));
            }
        }

        public string Activity { get; set; }
        public string Id { get; set; }
        public string Result { get; set; }
    }

    public class Mt4P2RLogEntryAnalysis : ITimed
    {
        public DateTime TimeStamp { get; set; }
// ReSharper disable InconsistentNaming
        public long U_INIT { get; set; }
        public long U_TRANS_ADD { get; set; }
        public long U_TRANS_DELETE { get; set; }
        public long U_TRANS_UPDATE { get; set; }
        // public List<Mt4P2RLogEntry> Mt4P2RLogEntries { get; set; } //debug info
// ReSharper restore InconsistentNaming
    }

    public interface ITimed
    {
        DateTime TimeStamp { get; set; }
    }

    public class LogEntryStatisticalAnalysis
    {
        public string Event { get; set; }
        public decimal Duration { get; set; }
        public decimal Max { get; set; }
        public decimal Average { get; set; }
        public decimal Total { get; set; }
        //  public string FieldName { get; set; }
    }

    public static class Mt4P2RLogEntryExtensions
    {
        public static List<Mt4P2RLogEntryAnalysis> AnalyseActionsByFrequency(
            this IEnumerable<Mt4P2RLogEntry> mt4P2RLogEntries)
        {
            List<Mt4P2RLogEntryAnalysis> list = (from lf in mt4P2RLogEntries
                let groupTimeStamp =
                    new DateTime(lf.TimeStamp.DateTime.Year, lf.TimeStamp.DateTime.Month, lf.TimeStamp.DateTime.Day,
                        lf.TimeStamp.DateTime.Hour, lf.TimeStamp.DateTime.Minute, lf.TimeStamp.DateTime.Second, 0)
                group lf by new {groupTimeStamp}
                into timeGroup
                select new Mt4P2RLogEntryAnalysis
                {
                    TimeStamp = timeGroup.Key.groupTimeStamp,
                    U_INIT = timeGroup.Count(a => a.Activity == "U_INIT:"),
                    U_TRANS_ADD = timeGroup.Count(a => a.Activity == "U_TRANS_ADD:"),
                    U_TRANS_DELETE = timeGroup.Count(a => a.Activity == "U_TRANS_DELETE:"),
                    U_TRANS_UPDATE = timeGroup.Count(a => a.Activity == "U_TRANS_UPDATE:"),
                    //Mt4P2RLogEntries = timeGroup.ToList() // debug info
                }
                ).ToList();
            return list;
        }

        public static void CreateAnalysisGraph(this IEnumerable<Mt4P2RLogEntryAnalysis> mt4P2RLogEntryAnalysisList,
            string graphName, string scenarioOutputDirectory, int axisXMajorGridInterval = 60)
        {
            mt4P2RLogEntryAnalysisList.EnumerableToLineGraph(
                new EnumerableToGraphExtensions.DataSeriesParameters
                {
                    PropertyName = "TimeStamp",
                    ChartValueType = ChartValueType.DateTime
                },
                new List<EnumerableToGraphExtensions.DataSeriesParameters>
                {
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "U_INIT",
                        SeriesName = "U_INIT"
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "U_TRANS_ADD",
                        SeriesName = "U_TRANS_ADD"
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "U_TRANS_DELETE",
                        SeriesName = "U_TRANS_DELETE"
                    },
                    new EnumerableToGraphExtensions.DataSeriesParameters
                    {
                        PropertyName = "U_TRANS_UPDATE",
                        SeriesName = "U_TRANS_UPDATE"
                    }
                },
                new EnumerableToGraphExtensions.ChartOptions
                {
                    FilePath = scenarioOutputDirectory,
                    Name = graphName,
                    AxisXMajorGridInterval = axisXMajorGridInterval
                }
                );
        }

        public static List<LogEntryStatisticalAnalysis> GenerateStatisics<T>(
            this List<T> eventList) where T : ITimed, new()
        {
            var duration = (decimal) (eventList.Last().TimeStamp - eventList.First().TimeStamp).TotalSeconds;
            // get numeric fields from T

            IEnumerable<PropertyInfo> numericFields = TypeExtensions.GetNumericFields<T>();
            return (from numericField in numericFields
                let values = eventList.Select(logEvent => Convert.ToDecimal(logEvent.GetValue(numericField))).ToList()
                let total = values.Sum()
                select new LogEntryStatisticalAnalysis
                {
                    Event = numericField.Name,
                    Average = Decimal.Divide(total, duration),
                    Duration = duration,
                    Max = values.Max(),
                    Total = total
                }).ToList();
        }
    }
}