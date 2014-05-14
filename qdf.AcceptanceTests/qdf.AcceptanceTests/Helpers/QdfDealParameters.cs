using System;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;

namespace qdf.AcceptanceTests.Helpers
{
    /// <summary>
    ///     Used as a table step conversion argument. if the table is missing some of the properties, the values for these
    ///     properties are null
    /// </summary>
    [UsedImplicitly]
    public class QdfDealParameters
    {
        public string Server { get; set; }
        public string Symbol { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
    }
}