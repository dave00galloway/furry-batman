using System;

namespace qdf.AcceptanceTests.Helpers
{
    /// <summary>
    ///     Used as a table step conversion argument. if the table is missing some of the properties, the values for these
    ///     properties are null
    /// </summary>
    public class QdfDealParameters
    {
        public string server { get; set; }
        public string symbol { get; set; }
        public string startTime { get; set; }
        public string endTime { get; set; }
        public DateTime convertedStartTime { get; set; }
        public DateTime convertedEndTime { get; set; }
    }
}