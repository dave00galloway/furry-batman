using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDelta
    {
        public Source LoSource { get; set; }
        public Source HiSource { get; set; }
        public List<Source> OtherSources { get; set; } 
        public Decimal Diff { get; set; }
    }
}
