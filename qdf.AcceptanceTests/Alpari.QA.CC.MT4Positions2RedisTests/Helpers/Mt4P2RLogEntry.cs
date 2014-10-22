using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4P2RLogEntry
    {
       //// public DateTime TimeStamp { get; set; }
       // /// <summary>
       // /// Should be a DateTime, but finding a nice way of getting the date formatted, keeping all the precision, proving dificcult
       // /// </summary>
       // public string TimeStamp { get; set; }


        // private DateTime _timeStamp;
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
                var date = Convert.ToDateTime(_date);
                var time = Convert.ToDateTime(_time);
                return new TimeStamp(date.Add(time.TimeOfDay));
            }
        }
        //public DateTime TimeStamp
        //{
        //    get
        //    {
        //        var date = Convert.ToDateTime(_date);
        //        var time = Convert.ToDateTime(_time);
        //        return date.Add(time.TimeOfDay);
        //    }
        //}

        public string Activity { get; set; }
        public string Id { get; set; }
        public string Result { get; set; }
    }

    public class Mt4P2RLogEntryAnalysis
    {
        public DateTime TimeStamp { get; set; }
// ReSharper disable InconsistentNaming
        public long U_INIT { get; set; }
        public long U_TRANS_ADD { get; set; }
        public long U_TRANS_DELETE { get; set; }
        public long U_TRANS_UPDATE { get; set; }
// ReSharper restore InconsistentNaming
    }

    public static class Mt4P2RLogEntryExtensions
    {
        public static List<Mt4P2RLogEntryAnalysis> GetValue(this IEnumerable<Mt4P2RLogEntry> mt4P2RLogEntries)
        {
            var list = (from lf in mt4P2RLogEntries
                let groupTimeStamp =
                    new DateTime(lf.TimeStamp.DateTime.Year, lf.TimeStamp.DateTime.Month, lf.TimeStamp.DateTime.Day,
                        lf.TimeStamp.DateTime.Hour, lf.TimeStamp.DateTime.Minute, lf.TimeStamp.DateTime.Second, 0)
                group lf by new { groupTimeStamp }
                into timeGoup
                select new Mt4P2RLogEntryAnalysis
                {
                    TimeStamp = timeGoup.Key.groupTimeStamp,
                    U_INIT = timeGoup.Count(a => a.Activity == "U_INIT:"),
                    U_TRANS_ADD = timeGoup.Count(a => a.Activity == "U_TRANS_ADD:"),
                    U_TRANS_DELETE = timeGoup.Count(a => a.Activity == "U_TRANS_DELETE:"),
                    U_TRANS_UPDATE = timeGoup.Count(a => a.Activity == "U_TRANS_UPDATE:"),
                }
                ).ToList();
            return list;
        }
    }
}
