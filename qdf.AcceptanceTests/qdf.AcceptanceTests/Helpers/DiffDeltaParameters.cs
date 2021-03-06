﻿using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using System;

namespace qdf.AcceptanceTests.Helpers
{
    [UsedImplicitly]
    public class DiffDeltaParameters
    {
        public string Server { get; set; }
        public string Symbol { get; set; }
        public string Book { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int  NumberOfDiffs { get; set; }
    }
}
