using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.CC
{
    public class SnapshotComparison
    {
        public string SnapshotTimeToMinute { get; set; }
        public string Server1Name { get; set; }
        public string Server2Name { get; set; }
        public decimal Server1Volume { get; set; }
        public decimal Server2Volume { get; set; }
        public decimal Diff { get; set; }
        public decimal Delta { get; set; }
    }
}
