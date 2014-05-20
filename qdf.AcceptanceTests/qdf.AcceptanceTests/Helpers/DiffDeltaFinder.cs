using System;
using System.Collections.Generic;
using System.Linq;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDeltaFinder
    {
        private int MaxDiffs { get; set; }
        private SignalsCompareDataDataContext SignalsCompareDataDataContext { get; set; }
        private DiffDeltaParameters DiffDeltaParameters { get; set; }
        public List<DiffDelta> DiffDeltas { get; set; }

        public void AnalyseDiffDeltas(DiffDeltaParameters diffDeltaParameters, SignalsCompareDataDataContext signalsCompareDataDataContext)
        {
            MaxDiffs = diffDeltaParameters.NumberOfDiffs;
            DiffDeltaParameters = diffDeltaParameters;
            SignalsCompareDataDataContext = signalsCompareDataDataContext;
            var data  = GetComparisonData();
            DiffDeltas = GetDiffDeltas(data, MaxDiffs);
            GetRelatedData(DiffDeltas);
        }

        private static List<DiffDelta> GetDiffDeltas(IOrderedQueryable<CompareData> data, int maxDiffs)
        {
            var list = new List<DiffDelta>(maxDiffs)
            {
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta(),
                new DiffDelta()
            };
            DiffDelta prevDiffDelta = null;
            DiffDelta diffDelta = null;
            DiffDelta tempDiffDelta = null;
            foreach (CompareData compareData in data)
            {
                switch ((Source)Enum.Parse(typeof(Source),compareData.Source))
                {
                    case Source.ARS:
                        if (tempDiffDelta != null) diffDelta.EndTimeStamp = compareData.TimeStamp;
                        prevDiffDelta = diffDelta;
                        list = AddSortAndTrimDiffDeltas(maxDiffs, prevDiffDelta, list);
                        diffDelta = prevDiffDelta != null ? new DiffDelta(prevDiffDelta) : new DiffDelta();
                        tempDiffDelta = diffDelta;
                        tempDiffDelta.StartTimeStamp = compareData.TimeStamp;
                        tempDiffDelta.ArsPosition = compareData.Position;
                        break;

                    case Source.ECN:
                        if (tempDiffDelta != null) tempDiffDelta.EcnPosition = compareData.Position;
                        SetEndTimeStampToLatestTimeStamp(tempDiffDelta, compareData);
                        break;

                    case Source.CC:
                        if (tempDiffDelta != null) tempDiffDelta.CcPosition += compareData.Position;
                        SetEndTimeStampToLatestTimeStamp(tempDiffDelta, compareData);
                        break;
                }
            }
            list = AddSortAndTrimDiffDeltas(maxDiffs, prevDiffDelta, list);
            return list;
        }

        private void GetRelatedData(List<DiffDelta> diffDeltas)
        {
            var relatedData = from cd in SignalsCompareDataDataContext.CompareDatas
                              where cd.Book == DiffDeltaParameters.Book
                              where cd.Symbol == DiffDeltaParameters.Symbol
                              where cd.Server == DiffDeltaParameters.Server
                              orderby cd.TimeStamp
                              select cd;

            foreach (DiffDelta diffDelta in diffDeltas)
            {
                diffDelta.CompareData =
                    new List<CompareData>(relatedData.Where(
                        x => x.TimeStamp >= diffDelta.StartTimeStamp && x.TimeStamp < diffDelta.EndTimeStamp));
            }
        }

        private static void SetEndTimeStampToLatestTimeStamp(DiffDelta tempDiffDelta, CompareData compareData)
        {
            if (tempDiffDelta != null && tempDiffDelta.EndTimeStamp < compareData.TimeStamp)
            {
                tempDiffDelta.EndTimeStamp = compareData.TimeStamp;
            }
        }

        private static List<DiffDelta> AddSortAndTrimDiffDeltas(int maxDiffs, DiffDelta prevDiffDelta, List<DiffDelta> list)
        {
            if (prevDiffDelta != null)
            {
                prevDiffDelta.CalculateDiffDelta();
                list.Add(prevDiffDelta);
                list = list.OrderByDescending(x => x.Delta).ThenByDescending(x=>Math.Abs(x.Diff)).ToList();
                list.RemoveAt(maxDiffs);
            }
            return list;
        }

        private IOrderedQueryable<CompareData> GetComparisonData()
        {
            var comparisonDataQuery = from cd in SignalsCompareDataDataContext.CompareDatas
                where cd.Book == DiffDeltaParameters.Book
                where cd.Symbol == DiffDeltaParameters.Symbol
                where cd.Server == DiffDeltaParameters.Server
                where cd.TimeStamp >= DiffDeltaParameters.StartDate && cd.TimeStamp < DiffDeltaParameters.EndDate
                where cd.Section != "Deal"
                orderby cd.TimeStamp
                select cd;
            return comparisonDataQuery;

        }
    }
}
