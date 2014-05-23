using System;
using System.Collections.Generic;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDelta
    {
        public Source LoSource { get; private set; }
        public Source HiSource { get; private set; }
        public Decimal Diff { get; private set; }
        public Decimal Delta { get; private set; }
        private Decimal ArsCcDiff { get; set; }
        private Decimal ArsCcDelta { get; set; }
        private Decimal ArsEcnDiff { get; set; }
        private Decimal ArsEcnDelta { get; set; }
        private Decimal CcEcnDiff { get; set; }
        private Decimal CcEcnDelta { get; set; }
        /// <summary>
        /// Default position if a position is required e.g. for exception handling
        /// </summary>
        public Decimal ArsPosition { get; set; }
        public Decimal CcPosition { get; set; }
        public Decimal EcnPosition { private get; set; }
        public DateTime StartTimeStamp { get; set; }
        public DateTime EndTimeStamp { get; set; }
        public List<ICompareDataTable> CompareData { get; set; }

        public DiffDelta PrevDiffDelta { get; private set; }

        public DiffDelta()
        {
            PrevDiffDelta = null;
        }

        public DiffDelta(DiffDelta prevDiffDelta)
        {
            PrevDiffDelta = prevDiffDelta;
        }

        public void CalculateDiffDelta()
        {
            ArsCcDiff = Math.Abs( Math.Abs(ArsPosition) - Math.Abs(CcPosition));
            ArsCcDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsCcDiff - ArsCcDiff : 0;
            ArsEcnDiff = Math.Abs( Math.Abs(ArsPosition) - Math.Abs(EcnPosition));
            ArsEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsEcnDiff - ArsEcnDiff : 0;
            CcEcnDiff = Math.Abs( Math.Abs(CcPosition) - Math.Abs(EcnPosition));
            CcEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.CcEcnDiff - CcEcnDiff : 0;
            var dictionary = new Dictionary<Tuple<Source, Source>, Tuple<Decimal, Decimal>>
            {
                {
                    new Tuple<Source, Source>(Source.ARS, Source.CC), 
                    new Tuple<decimal, decimal>(ArsCcDiff, ArsCcDelta)
                },
                {
                    new Tuple<Source, Source>(Source.ARS, Source.ECN),
                    new Tuple<decimal, decimal>(ArsEcnDiff, ArsEcnDelta)
                },
                {
                    new Tuple<Source, Source>(Source.CC, Source.ECN), 
                    new Tuple<decimal, decimal>(CcEcnDiff, CcEcnDelta)
                }
            };

            var maxDelta =
                default(KeyValuePair<Tuple<Source, Source>, Tuple<decimal, decimal>>);
            foreach (var keyValuePair in dictionary)
            {
                if (maxDelta.Value == null || Math.Abs(keyValuePair.Value.Item2) > Math.Abs(maxDelta.Value.Item2))
                {
                    maxDelta = keyValuePair;
                }
            }
            LoSource = maxDelta.Key.Item1;
            HiSource = maxDelta.Key.Item2;
            Diff = maxDelta.Value.Item1;
            Delta = maxDelta.Value.Item2;
        }
    }
}
