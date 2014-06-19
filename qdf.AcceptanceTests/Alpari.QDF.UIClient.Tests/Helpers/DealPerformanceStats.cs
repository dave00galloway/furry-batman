using Alpari.QDF.UIClient.App.Annotations;

namespace Alpari.QDF.UIClient.Tests.Helpers
{
    [UsedImplicitly]
    public class DealPerformanceStats
    {
// ReSharper disable UnusedMember.Global
        public decimal ExecutionTime { get; set; }
        public long QuerySize { get; set; }
        public string QuerySizeFormatted { get; set; }
        public decimal QuerySpeedInBytesPerSecond { get; set; }
        public string QuerySpeedInBytesPerSecondFormatted { get; set; }
        public int DealCount { get; set; }
        public int TotalDealCount { get; set; }
        public decimal DealQuerySpeedInDealsPerSecond { get; set; }
        public string DealQuerySpeedInDealsPerSecondFormatted { get; set; }
        public decimal TotalDealQuerySpeedInDealsPerSecond { get; set; }
        public string TotalDealQuerySpeedInDealsPerSecondFormatted { get; set; }
// ReSharper restore UnusedMember.Global
    }
    
}