using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDelta
    {
        public Source LoSource { get; set; }
        public Source HiSource { get; set; }
        public Decimal Diff { get; set; }
        public Decimal Delta { get; set; }
        public Decimal ArsCcDiff { get; set; }
        public Decimal ArsCcDelta { get; set; }
        public Decimal ArsEcnDiff { get; set; }
        public Decimal ArsEcnDelta { get; set; }
        public Decimal CcEcnDiff { get; set; }
        public Decimal CcEcnDelta { get; set; }
        public Decimal ArsPosition { get; set; }
        public Decimal CcPosition { get; set; }
        public Decimal EcnPosition { get; set; }

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
            // ArsCcDiff = Math.Abs(ArsPosition - CcPosition); // should we use Abs?
            ArsCcDiff = ArsPosition - CcPosition;
            ArsCcDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsCcDiff - ArsCcDiff : ArsCcDiff;
            ArsEcnDiff = ArsPosition - EcnPosition;
            ArsEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsEcnDiff - ArsEcnDiff : ArsEcnDiff;
            CcEcnDiff = CcPosition - EcnPosition;
            CcEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.CcEcnDelta - CcEcnDiff : CcEcnDiff;
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
            //var maxDelta = dictionary.FirstOrDefault(x => Equals(x.Value, dictionary.Values.Max())).Key;
            var maxDelta =
                default(KeyValuePair<Tuple<Source, Source>, Tuple<decimal, decimal>>);
            foreach (var keyValuePair in dictionary)
            {
                if (Math.Abs(keyValuePair.Value.Item1) > Math.Abs(maxDelta.Value.Item1))
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
