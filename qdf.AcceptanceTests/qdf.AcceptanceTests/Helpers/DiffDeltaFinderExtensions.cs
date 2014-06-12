using System;
using System.Collections.Generic;
using System.Linq;

namespace qdf.AcceptanceTests.Helpers
{
    public static class DiffDeltaFinderExtensions
    {
        public static List<DiffDelta> CalculateSortAndTrimDeltas(this List<DiffDelta> list, int maxDiffs)
        {
            list.ForEach(x=>x.CalculateDiffDelta());
            list = list.OrderByDescending(x => Math.Abs(x.Delta)).ThenByDescending(x => Math.Abs(x.Diff)).ToList();
            list = list.Take(maxDiffs).ToList();
            return list;
        }
    }
}
