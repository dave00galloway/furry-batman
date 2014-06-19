using System.Globalization;
using System.Linq;

namespace Alpari.QDF.UIClient.App
{
    public class QuoteQueryPerformance
    {
        private int _quoteCount;
        private readonly PerformanceStats _performanceStats;
        private decimal _quoteQuerySpeedInDealsPerSecond;
        private string _quoteQuerySpeedInDealsPerSecondFormatted;
        private int _totalQuoteCount;
        private decimal _totalQuoteQuerySpeedInDealsPerSecond;
        private string _totalQuoteQuerySpeedInDealsPerSecondFormatted;
        //private decimal _quoteQuerySpeedInBytesPerSecond;
        //private string _quoteQuerySpeedInBytesPerSecondFormatted;

        public QuoteQueryPerformance(PerformanceStats performanceStats)
        {
            _performanceStats = performanceStats;
        }

        /// <summary>
        /// gets the number of quotes returned by the query that are of interest to the user
        /// </summary>
        public int QuoteCount
        {
            get
            {
                if (_quoteCount == default (int))
                {
                    QuoteCount = _performanceStats.RedisConnectionHelper.RetrievedQuotes.Count;
                }
                return _quoteCount;
            }
            private set { _quoteCount = value; }
        }

        /// <summary>
        /// gets number of quotes returned by query before client side filtering
        /// </summary>
        public int TotalQuoteCount
        {
            get
            {
                if (_totalQuoteCount == default(int))
                {
                    TotalQuoteCount = _performanceStats.RedisConnectionHelper.RedisQuoteSearches.TotalRetrievedQuotes.Count();
                }
                return _totalQuoteCount;
            }
            private set { _totalQuoteCount = value; }
        }

        public decimal QuoteQuerySpeedInDealsPerSecond
        {
            get
            {
                if (_quoteQuerySpeedInDealsPerSecond == default(decimal) && _performanceStats.ExecutionTime > 0)
                {
                    QuoteQuerySpeedInDealsPerSecond = QuoteCount / _performanceStats.ExecutionTime;
                }
                return _quoteQuerySpeedInDealsPerSecond;
            }
            private set { _quoteQuerySpeedInDealsPerSecond = value; }
        }

        public string QuoteQuerySpeedInDealsPerSecondFormatted
        {
            get
            {
                if (_quoteQuerySpeedInDealsPerSecondFormatted == default(string))
                {
                    QuoteQuerySpeedInDealsPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
                        "{0:N0} Quotes/Second", QuoteQuerySpeedInDealsPerSecond);
                }
                return _quoteQuerySpeedInDealsPerSecondFormatted;
            }
            private set { _quoteQuerySpeedInDealsPerSecondFormatted = value; }
        }

        public decimal TotalQuoteQuerySpeedInDealsPerSecond
        {
            get
            {
                if (_totalQuoteQuerySpeedInDealsPerSecond == default(decimal) && _performanceStats.ExecutionTime > 0)
                {
                    TotalQuoteQuerySpeedInDealsPerSecond = TotalQuoteCount / _performanceStats.ExecutionTime;
                }
                return _totalQuoteQuerySpeedInDealsPerSecond;
            }
            private set { _totalQuoteQuerySpeedInDealsPerSecond = value; }
        }

        public string TotalQuoteQuerySpeedInDealsPerSecondFormatted
        {
            get
            {
                if (_totalQuoteQuerySpeedInDealsPerSecondFormatted == default(string))
                {
                    TotalQuoteQuerySpeedInDealsPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
                        "{0:N0} Quotes/Second", _totalQuoteQuerySpeedInDealsPerSecondFormatted);
                }
                return _totalQuoteQuerySpeedInDealsPerSecondFormatted;
            }
            private set { _totalQuoteQuerySpeedInDealsPerSecondFormatted = value; }
        }
    }
}