using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using qdf.AcceptanceTests.DataContexts;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDeltaFinder
    {
        private int MaxDiffs { get; set; }
        private SignalsCompareDataDataContext SignalsCompareDataDataContext { get; set; }
        private SignalsCompareDataSnapOnCCDataContext SignalsCompareDataSnapOnCcDataContext { get; set; }
        private DiffDeltaParameters DiffDeltaParameters { get; set; }
        public List<DiffDelta> DiffDeltas { get; private set; }

        public void AnalyseDiffDeltas(DiffDeltaParameters diffDeltaParameters, SignalsCompareDataDataContext signalsCompareDataDataContext)
        {
            MaxDiffs = diffDeltaParameters.NumberOfDiffs;
            DiffDeltaParameters = diffDeltaParameters;
            SignalsCompareDataDataContext = signalsCompareDataDataContext;
            var data  = GetComparisonData().ToList<ICompareDataTable>();
            DiffDeltas = GetDiffDeltas(data, MaxDiffs);
            GetRelatedData(DiffDeltas);
        }

        public void AnalyseDiffDeltas(DiffDeltaParameters diffDeltaParameters, SignalsCompareDataSnapOnCCDataContext signalsCompareDataSnapOnCcDataContext)
        {
            MaxDiffs = diffDeltaParameters.NumberOfDiffs;
            DiffDeltaParameters = diffDeltaParameters;
            SignalsCompareDataSnapOnCcDataContext = signalsCompareDataSnapOnCcDataContext;
            var data = GetComparisonData(typeof(SignalsCompareDataSnapOnCCDataContext));
            DiffDeltas = GetDiffDeltas(data, MaxDiffs);
            GetRelatedData(DiffDeltas, typeof(SignalsCompareDataSnapOnCCDataContext));
        }

        private static List<DiffDelta> GetDiffDeltas(List<ICompareDataTable> data, int maxDiffs)
        {
            var list = new List<DiffDelta>(maxDiffs);
            for (int i = 0; i < maxDiffs; i++)
            {
                list.Add(new DiffDelta());
            }
            DiffDelta prevDiffDelta = null;
            DiffDelta diffDelta = null;
            DiffDelta tempDiffDelta = null;
            foreach (var compareData in data)
            {
                switch ((Source)Enum.Parse(typeof(Source),compareData.Source))
                {
                    case Source.ARS:
                        if (tempDiffDelta != null) diffDelta.EndTimeStamp = compareData.TimeStamp;
                        prevDiffDelta = diffDelta;
                        //list = AddSortAndTrimDiffDeltas(maxDiffs, prevDiffDelta, list);

                        if (prevDiffDelta != null)
                        {
                            list.Add(prevDiffDelta);
                        }
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
            //list = AddSortAndTrimDiffDeltas(maxDiffs, prevDiffDelta, list);
            list = list.CalculateSortAndTrimDeltas(maxDiffs);
            return list;
        }

        private void GetRelatedData(List<DiffDelta> diffDeltas, Type type)
        {
            switch (type.FullName)
            {
                case SignalsCompareDataSnapOnCCDataContext.FULL_NAME:
                    var relatedData =
                        SignalsCompareDataSnapOnCcDataContext.CompareDataSnapOnCCs.Where(cd => cd.Book == DiffDeltaParameters.Book)
                            .Where(cd => cd.Symbol == DiffDeltaParameters.Symbol)
                            .Where(cd => cd.Server == DiffDeltaParameters.Server)
                            .OrderBy(cd => cd.TimeStamp);

                    GetCompareDataForDiffDeltas(diffDeltas, relatedData);
                    break;
                case SignalsCompareDataDataContext.FULL_NAME:
                    GetRelatedData(diffDeltas);
                    break;
                default:
                    throw new ArgumentException("unable to get data for type", type.FullName);                    
            }
        }

        private void GetRelatedData(List<DiffDelta> diffDeltas)
        {
            var relatedData =
                SignalsCompareDataDataContext.CompareDatas.Where(cd => cd.Book == DiffDeltaParameters.Book)
                    .Where(cd => cd.Symbol == DiffDeltaParameters.Symbol)
                    .Where(cd => cd.Server == DiffDeltaParameters.Server)
                    .OrderBy(cd => cd.TimeStamp);

            GetCompareDataForDiffDeltas(diffDeltas, relatedData);
        }

        private void GetCompareDataForDiffDeltas(List<DiffDelta> diffDeltas, IOrderedQueryable<ICompareDataTable> relatedData)
        {
            foreach (DiffDelta diffDelta in diffDeltas)
            {
                diffDelta.CompareData =
                    GetCompareDataForDiffDelta(relatedData, diffDelta);
            }
        }

        private List<ICompareDataTable> GetCompareDataForDiffDelta(IOrderedQueryable<ICompareDataTable> relatedData, DiffDelta diffDelta)
        {
            try
            {
                return new List<ICompareDataTable>(relatedData.Where(
                        x => x != null && (x.TimeStamp >= diffDelta.StartTimeStamp && x.TimeStamp < diffDelta.EndTimeStamp)));
            }
            catch (Exception e)
            {
                var message = string.Format("Unable to get related data for {0} {1} {2} ending at {3}", DiffDeltaParameters.Book.ToString(CultureInfo.InvariantCulture),DiffDeltaParameters.Symbol,DiffDeltaParameters.Server,diffDelta.EndTimeStamp);
                e.ConsoleExceptionLogger(message);
                return new List<ICompareDataTable>
                {
                    new CompareData
                    {
                        Book = DiffDeltaParameters.Book.ToString(CultureInfo.InvariantCulture),
                        Symbol = DiffDeltaParameters.Symbol,
                        Server = DiffDeltaParameters.Server,
                        Position = diffDelta.ArsPosition,
                        Section =  message,
                        Id = 0,
                        RawPosition = diffDelta.ArsPosition,
                        Source = "?",
                        TimeStamp = diffDelta.EndTimeStamp
                    }
                };
            }
        }

        private static void SetEndTimeStampToLatestTimeStamp(DiffDelta tempDiffDelta, ICompareDataTable compareData)
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

        private List<ICompareDataTable> GetComparisonData(Type type)
        {
            switch (type.FullName)
            {
                case SignalsCompareDataSnapOnCCDataContext.FULL_NAME:
                    var comparisonDataQuery = from cd in SignalsCompareDataSnapOnCcDataContext.CompareDataSnapOnCCs
                        where cd.Book == DiffDeltaParameters.Book
                        where cd.Symbol == DiffDeltaParameters.Symbol
                        where cd.Server == DiffDeltaParameters.Server
                        where cd.TimeStamp >= DiffDeltaParameters.StartDate && cd.TimeStamp < DiffDeltaParameters.EndDate
                        where cd.Section != "Deal"
                        orderby cd.TimeStamp
                        select cd;
                    return comparisonDataQuery.ToList<ICompareDataTable>();
                case SignalsCompareDataDataContext.FULL_NAME:
                    return GetComparisonData().ToList<ICompareDataTable>();
                default:
                    throw new ArgumentException("unable to get data for type", type.FullName);
            }
        }   
    }
}
