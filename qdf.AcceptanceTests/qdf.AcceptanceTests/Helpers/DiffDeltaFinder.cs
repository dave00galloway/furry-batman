using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Authentication;
using System.Text;
using System.Threading.Tasks;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDeltaFinder
    {
        private int MaxDiffs { get; set; }
        private SignalsCompareDataDataContext SignalsCompareDataDataContext { get; set; }
        private DiffDeltaParameters DiffDeltaParameters { get; set; }

        public void AnalyseDiffDeltas(DiffDeltaParameters diffDeltaParameters, SignalsCompareDataDataContext signalsCompareDataDataContext)
        {
            MaxDiffs = diffDeltaParameters.NumberOfDiffs;
            DiffDeltaParameters = diffDeltaParameters;
            SignalsCompareDataDataContext = signalsCompareDataDataContext;
            var data  = GetComparisonData();//.ToList();
            List<DiffDelta> analysed = GetDiffDeltas(data, MaxDiffs);
        }

        private List<DiffDelta> GetDiffDeltas(IOrderedQueryable<CompareData> data, int maxDiffs)
        {
            List<DiffDelta> list = new List<DiffDelta>(maxDiffs+1);
            DiffDelta prevDiffDelta = null;// = new DiffDelta();
            DiffDelta diffDelta = null;
            DiffDelta tempDiffDelta = null;
            foreach (CompareData compareData in data)
            {
                if (compareData.Source == "ARS" && compareData.Section == "Clock")
                {
                    prevDiffDelta = diffDelta;

                    if (tempDiffDelta == null)
                    {
                        diffDelta = new DiffDelta();
                    }
                    else
                    {
                        diffDelta = new DiffDelta(prevDiffDelta);
                    }
                    tempDiffDelta = diffDelta;
                }
            }
            throw new NotImplementedException();
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
