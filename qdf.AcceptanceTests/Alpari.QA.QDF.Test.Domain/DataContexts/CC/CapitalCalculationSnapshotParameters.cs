using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.CC
{
    public class CapitalCalculationSnapshotParameters
    {
        private string _database1 = "cc_qa";
        private string _database2 = "cc_uat";
        //| server | section | book | symbol | startTime           | endTime             |
    //| MT5    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/09/28 20:14:00 | 
        public string Server { get; set; }
        public string Section { get; set; }
        public string Book { get; set; }
        public string Symbol { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public DateTime QueryDateTime { get; set; }

        public string Database1
        {
            get { return _database1; }
            set { _database1 = value; }
        }

        public string Database2
        {
            get { return _database2; }
            set { _database2 = value; }
        }
    }
}
