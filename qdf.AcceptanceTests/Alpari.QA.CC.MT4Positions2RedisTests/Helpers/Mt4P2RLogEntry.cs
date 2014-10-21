using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public DateTime TimeStamp
        {
            get
            {
                var date = Convert.ToDateTime(_date);
                var time = Convert.ToDateTime(_time);
                return date.Add(time.TimeOfDay);
            }
        }

        public string Activity { get; set; }
        public string Id { get; set; }
        public string Result { get; set; }
    }
}
