using System.Globalization;
using System.Linq;

namespace Alpari.QDF.UIClient.App
{
    public class DealQueryPerformance
    {
        private readonly PerformanceStats _performanceStats;
        private int _dealCount;
        private int _totalDealCount;
        private decimal _dealQuerySpeedInBytesPerSecond;
        private string _dealQuerySpeedInBytesPerSecondFormatted;
        private decimal _dealQuerySpeedInDealsPerSecond;
        private string _dealQuerySpeedInDealsPerSecondFormatted;
        private decimal _totalDealQuerySpeedInDealsPerSecond;
        private string _totalDealQuerySpeedInDealsPerSecondFormatted;

        public DealQueryPerformance(PerformanceStats performanceStats)
        {
            _performanceStats = performanceStats;
        }



        /// <summary>
        /// gets the number of deals returned by the query that are of interest to the user
        /// </summary>
        public int DealCount
        {
            get
            {
                if (_dealCount == default (int))
                {
                    DealCount = _performanceStats.RedisConnectionHelper.RetrievedDeals.Count;
                }
                return _dealCount;
            }
            private set { _dealCount = value; }
        }

        /// <summary>
        /// gets number of deals returned by query before client side filtering
        /// </summary>
        public int TotalDealCount
        {
            get
            {
                if (_totalDealCount == default (int))
                {
                    TotalDealCount = _performanceStats.RedisConnectionHelper.RedisDealSearches.TotalRetrievedDeals.Count();
                }
                return _totalDealCount;
            }
            private set { _totalDealCount = value; }
        }

        public decimal DealQuerySpeedInDealsPerSecond
        {
            get
            {
                if (_dealQuerySpeedInDealsPerSecond == default(decimal) && _performanceStats.ExecutionTime > 0)
                {
                    DealQuerySpeedInDealsPerSecond = DealCount/_performanceStats.ExecutionTime;
                }
                return _dealQuerySpeedInDealsPerSecond;
            }
            private set { _dealQuerySpeedInDealsPerSecond = value; }
        }

        public string DealQuerySpeedInDealsPerSecondFormatted
        {
            get
            {
                if (_dealQuerySpeedInDealsPerSecondFormatted == default (string))
                {
                    DealQuerySpeedInDealsPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
                        "{0:N0} Deals/Second", DealQuerySpeedInDealsPerSecond);
                }
                return _dealQuerySpeedInDealsPerSecondFormatted;
            }
            private set { _dealQuerySpeedInDealsPerSecondFormatted = value; }
        }

        public decimal TotalDealQuerySpeedInDealsPerSecond
        {
            get
            {
                if (_totalDealQuerySpeedInDealsPerSecond == default (decimal) && _performanceStats.ExecutionTime > 0)
                {
                    TotalDealQuerySpeedInDealsPerSecond = TotalDealCount/_performanceStats.ExecutionTime;
                }
                return _totalDealQuerySpeedInDealsPerSecond;
            }
            private set { _totalDealQuerySpeedInDealsPerSecond = value; }
        }

        public string TotalDealQuerySpeedInDealsPerSecondFormatted
        {
            get
            {
                if (_totalDealQuerySpeedInDealsPerSecondFormatted == default(string))
                {
                    TotalDealQuerySpeedInDealsPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
                        "{0:N0} Deals/Second", TotalDealQuerySpeedInDealsPerSecond);
                }
                return _totalDealQuerySpeedInDealsPerSecondFormatted;
            }
            set { _totalDealQuerySpeedInDealsPerSecondFormatted = value; }
        }
    }
}