using Alpari.QDF.UIClient.App.ControlHelpers;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;

namespace Alpari.QDF.UIClient.App
{
    public class PerformanceStats
    {
        private TimeSpan _executionTime;
        private long _initialMemory;
        private long _querySize;
        private readonly DealQueryPerformance _dealQueryPerformance;
        private readonly QuoteQueryPerformance _quoteQueryPerformance;
        private decimal _querySpeedInBytesPerSecond;
        private string _querySpeedInBytesPerSecondFormatted;

        public PerformanceStats(RedisConnectionHelper redisConnectionHelper)
        {
            RedisConnectionHelper = redisConnectionHelper;
            QueryTimer = new Stopwatch();
            _dealQueryPerformance = new DealQueryPerformance(this);
            _quoteQueryPerformance = new QuoteQueryPerformance(this);
            QuerySizeFormatted = "";
            QuerySpeedInBytesPerSecondFormatted = "";

        }

        /// <summary>
        ///     time in seconds that a query took to run
        /// </summary>
        public decimal ExecutionTime
        {
            get
            {
                if (_executionTime.TotalSeconds > 0)
                {
                    return (decimal) _executionTime.TotalSeconds;
                }
                return ((decimal) _executionTime.TotalMilliseconds)/1000;
            }
        }

        internal RedisConnectionHelper RedisConnectionHelper { get; set; }
        private Stopwatch QueryTimer { get; set; }

        public DealQueryPerformance DealQueryPerformance
        {
            get { return _dealQueryPerformance; }
        }

        public QuoteQueryPerformance QuoteQueryPerformance
        {
            get { return _quoteQueryPerformance; }
        }

        public long QuerySize
        {
            get { return _querySize; }
            private set
            {
                if (value < 0)
                {
                    value = 0;
                }
                _querySize = value;
            }
        }

        public string QuerySizeFormatted { get; private set; }

        public decimal QuerySpeedInBytesPerSecond
        {
            get
            {
                if (_querySpeedInBytesPerSecond == default(decimal) && ExecutionTime > 0)
                {
                    QuerySpeedInBytesPerSecond = QuerySize / ExecutionTime;
                }
                return _querySpeedInBytesPerSecond;
            }
            private set { _querySpeedInBytesPerSecond = value; }
        }

        public string QuerySpeedInBytesPerSecondFormatted
        {
            get
            {
                if (_querySpeedInBytesPerSecondFormatted == "")
                {
                    QuerySpeedInBytesPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
                        "{0:N0} Bytes/Second", QuerySpeedInBytesPerSecond);
                }
                return _querySpeedInBytesPerSecondFormatted;
            }
            private set { _querySpeedInBytesPerSecondFormatted = value; }
        }


        public void Start()
        {
            QueryTimer.Start();
            _initialMemory = GC.GetTotalMemory(true);
        }

        public void Stop()
        {
            QueryTimer.Stop();
            _executionTime = QueryTimer.Elapsed;
            QuerySize = (GC.GetTotalMemory(true) - _initialMemory);
            QuerySizeFormatted = string.Format(new CultureInfo("en-US"), "{0:N0} K", QuerySize/1024);
        }

        public string[] GetStats(string dataType)
        {
            switch (dataType)
            {
                case SupportedDataTypesControl.DEAL:
                case SupportedDataTypesControl.ECN_DEAL:
                    return new List<string>()
                    {
                        String.Format("ExecutionTime :- {0}",ExecutionTime.ToString(CultureInfo.InvariantCulture)),
                        String.Format("QuerySize :- {0}",QuerySizeFormatted),
                        String.Format("Query Speed in bytes :- {0}",QuerySpeedInBytesPerSecondFormatted),
                        String.Format("DealCount :- {0}",DealQueryPerformance.DealCount.ToString(CultureInfo.InvariantCulture)),
                        String.Format("Query Speed in deals :- {0}",DealQueryPerformance.DealQuerySpeedInDealsPerSecondFormatted),
                        String.Format("TotalDealCount :- {0}",DealQueryPerformance.TotalDealCount),
                        String.Format("Query Speed in total deals :- {0}",DealQueryPerformance.TotalDealQuerySpeedInDealsPerSecondFormatted)
                    }.ToArray();
                case SupportedDataTypesControl.PRICE_QUOTE:
                    return new List<string>()
                    {
                        String.Format("ExecutionTime :- {0}",ExecutionTime.ToString(CultureInfo.InvariantCulture)),
                        String.Format("QuerySize :- {0}",QuerySizeFormatted),
                        String.Format("Query Speed in bytes  :- {0}",QuerySpeedInBytesPerSecondFormatted),
                        String.Format("QuoteCount :- {0}",QuoteQueryPerformance.QuoteCount.ToString(CultureInfo.InvariantCulture)),
                        String.Format("Query Speed in deals  :- {0}",QuoteQueryPerformance.TotalQuoteCount.ToString(CultureInfo.InvariantCulture)),
                        String.Format("Query Speed in total Quotes :- {0}",QuoteQueryPerformance.TotalQuoteQuerySpeedInDealsPerSecondFormatted)
                    }.ToArray();

                default:
                    throw new NotSupportedException(String.Format("{0} is not supported",dataType));
            }

        }
    }
}