using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDeltaFinder
    {
        private int MaxDiffs { get; set; }

        public void AnalyseDiffDeltas(DiffDeltaParameters diffDeltaParameters)
        {
            MaxDiffs = diffDeltaParameters.NumberOfDiffs;
        }
    }
}
