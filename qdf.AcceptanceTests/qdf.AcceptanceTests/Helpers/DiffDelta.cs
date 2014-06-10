using System;
using System.Collections.Generic;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDelta
    {
        public DiffDelta()
        {
            PrevDiffDelta = null;
            InitialiseDataStreamFlags();
        }

        public DiffDelta(DiffDelta prevDiffDelta)
        {
            PrevDiffDelta = prevDiffDelta;
            InitialiseDataStreamFlags();
        }

        public Source LoSource { get; private set; }
        public Source HiSource { get; private set; }
        public Decimal Diff { get; private set; }
        public Decimal Delta { get; private set; }
        public bool ArsDetected { get; set; }
        public bool CcDetected { get; set; }
        public bool EcnDetected { get; set; }
        private Decimal ArsCcDiff { get; set; }
        private Decimal ArsCcDelta { get; set; }
        private Decimal ArsEcnDiff { get; set; }
        private Decimal ArsEcnDelta { get; set; }
        private Decimal CcEcnDiff { get; set; }
        private Decimal CcEcnDelta { get; set; }

        /// <summary>
        ///     Default position if a position is required e.g. for exception handling
        /// </summary>
        public Decimal ArsPosition { get; set; }

        public Decimal CcPosition { get; set; }
        public Decimal EcnPosition { private get; set; }
        public DateTime StartTimeStamp { get; set; }
        public DateTime EndTimeStamp { get; set; }
        public List<ICompareDataTable> CompareData { get; set; }

        public DiffDelta PrevDiffDelta { get; private set; }

        public void CalculateDiffDelta()
        {
            ArsCcDiff = Math.Abs(Math.Abs(ArsPosition) - Math.Abs(CcPosition));
            ArsCcDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsCcDiff - ArsCcDiff : 0;
            ArsEcnDiff = Math.Abs(Math.Abs(ArsPosition) - Math.Abs(EcnPosition));
            ArsEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.ArsEcnDiff - ArsEcnDiff : 0;
            CcEcnDiff = Math.Abs(Math.Abs(CcPosition) - Math.Abs(EcnPosition));
            CcEcnDelta = PrevDiffDelta != null ? PrevDiffDelta.CcEcnDiff - CcEcnDiff : 0;
            Dictionary<Tuple<Source, Source>, Tuple<decimal, decimal>> dictionary = SetupDiffDeltaDictionary();

            KeyValuePair<Tuple<Source, Source>, Tuple<decimal, decimal>> maxDelta =
                default(KeyValuePair<Tuple<Source, Source>, Tuple<decimal, decimal>>);
            foreach (var keyValuePair in dictionary)
            {
                if (maxDelta.Value == null || Math.Abs(keyValuePair.Value.Item2) > Math.Abs(maxDelta.Value.Item2))
                {
                    maxDelta = keyValuePair;
                }
            }

            if (!maxDelta.Equals(default(KeyValuePair<Tuple<Source, Source>, Tuple<decimal, decimal>>)))
            {
                LoSource = maxDelta.Key.Item1;
                HiSource = maxDelta.Key.Item2;
                Diff = maxDelta.Value.Item1;
                Delta = maxDelta.Value.Item2;
            }
        }

        private Dictionary<Tuple<Source, Source>, Tuple<decimal, decimal>> SetupDiffDeltaDictionary()
        {
            var dictionary = new Dictionary<Tuple<Source, Source>, Tuple<Decimal, Decimal>>();
            //{
            //    {
            //        new Tuple<Source, Source>(Source.ARS, Source.CC),
            //        new Tuple<decimal, decimal>(ArsCcDiff, ArsCcDelta)
            //    },
            //    {
            //        new Tuple<Source, Source>(Source.ARS, Source.ECN),
            //        new Tuple<decimal, decimal>(ArsEcnDiff, ArsEcnDelta)
            //    },
            //    {
            //        new Tuple<Source, Source>(Source.CC, Source.ECN),
            //        new Tuple<decimal, decimal>(CcEcnDiff, CcEcnDelta)
            //    }
            //}; can't use the initialiser as logic is needed to determine which combinations can be validly added
            //Source.ARS, Source.CC
            if (ArsDetected && CcDetected && (PrevDiffDelta != null && PrevDiffDelta.ArsDetected) &&
                (PrevDiffDelta != null && PrevDiffDelta.CcDetected))
            {
                dictionary.Add(new Tuple<Source, Source>(Source.ARS, Source.CC),
                    new Tuple<decimal, decimal>(ArsCcDiff, ArsCcDelta));
            }
            else
            {
                //carry forward the previous ARS position if the data is missing from this diff delta (should be impossible)
                if (PrevDiffDelta != null)
                {
                    if (!ArsDetected)
                    {
                        ArsPosition = PrevDiffDelta.ArsPosition;
                    }
                    if (!CcDetected)
                    {
                        CcPosition = PrevDiffDelta.CcPosition;
                    }
                    
                }
            }

            //Source.ARS, Source.ECN
            if (ArsDetected && EcnDetected && (PrevDiffDelta != null && PrevDiffDelta.CcDetected) &&
                (PrevDiffDelta != null && PrevDiffDelta.ArsDetected))
            {
                dictionary.Add(new Tuple<Source, Source>(Source.ARS, Source.ECN),
                    new Tuple<decimal, decimal>(ArsEcnDiff, ArsEcnDelta));
            }
            else
            {
                if (PrevDiffDelta != null)
                {
                    if (!ArsDetected)
                    {
                        ArsPosition = PrevDiffDelta.ArsPosition;
                    }
                    if (!EcnDetected)
                    {
                        EcnPosition = PrevDiffDelta.EcnPosition;
                    }
                }
            }

            //Source.CC, Source.ECN
            if (EcnDetected && CcDetected && (PrevDiffDelta != null && PrevDiffDelta.EcnDetected) &&
                (PrevDiffDelta != null && PrevDiffDelta.CcDetected))
            {
                dictionary.Add(new Tuple<Source, Source>(Source.CC, Source.ECN),
                    new Tuple<decimal, decimal>(CcEcnDiff, CcEcnDelta));
            }
            else
            {
                if (PrevDiffDelta != null)
                {
                    if (!EcnDetected)
                    {
                        EcnPosition = PrevDiffDelta.EcnPosition;
                    }
                    if (!CcDetected)
                    {
                        CcPosition = PrevDiffDelta.CcPosition;
                    }
                }
            }

            return dictionary;
        }

        private void InitialiseDataStreamFlags()
        {
            ArsDetected = false;
            CcDetected = false;
            EcnDetected = false;
        }
    }
}