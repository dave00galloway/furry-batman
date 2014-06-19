using System;
using System.Diagnostics;
using System.Globalization;

namespace Alpari.QDF.UIClient.App
{
    public class PerformanceStats
    {
        private int _dealCount;
        private long _dealQuerySize;
        private decimal _dealQuerySpeedInBytesPerSecond;
        private string _dealQuerySpeedInBytesPerSecondFormatted;
        private long _initialMemory;
        private decimal _dealQuerySpeedInDealsPerSecond;
        private TimeSpan _executionTime;

        public PerformanceStats(RedisConnectionHelper redisConnectionHelper)
        {
            RedisConnectionHelper = redisConnectionHelper;
            QueryTimer = new Stopwatch();
        }

        public TimeSpan ExecutionTime
        {
            get { return _executionTime; }
            private set { _executionTime = value; }
        }

        private RedisConnectionHelper RedisConnectionHelper { get; set; }
        private Stopwatch QueryTimer { get; set; }

        public long DealQuerySize
        {
            get { return _dealQuerySize; }
            private set
            {
                if (value < 0)
                {
                    value = 0;
                }
                _dealQuerySize = value;
            }
        }

        public string DealQuerySizeFormatted { get; private set; }

        public int DealCount
        {
            get
            {
                if (_dealCount == default (int))
                {
                    DealCount = RedisConnectionHelper.RetrievedDeals.Count;
                }
                return _dealCount;
            }
            private set { _dealCount = value; }
        }

        public decimal DealQuerySpeedInBytesPerSecond
        {
            get
            {
                if (_dealQuerySpeedInBytesPerSecond == default(long) && ExecutionTime.TotalSeconds > 0)
                {
                    DealQuerySpeedInBytesPerSecond = DealQuerySize/(decimal) ExecutionTime.TotalSeconds;
                }
                return _dealQuerySpeedInBytesPerSecond;
            }
            private set { _dealQuerySpeedInBytesPerSecond = value; }
        }

        public string DealQuerySpeedInBytesPerSecondFormatted
        {
            get
            {
                if (_dealQuerySpeedInBytesPerSecondFormatted == default (string))
                {
                    DealQuerySpeedInBytesPerSecondFormatted = string.Format(new CultureInfo("en-US"),
                        "{0:N0} Bytes/Second", DealQuerySpeedInBytesPerSecond);
                }
                return _dealQuerySpeedInBytesPerSecondFormatted;
            }
            private set { _dealQuerySpeedInBytesPerSecondFormatted = value; }
        }

        public decimal DealQuerySpeedInDealsPerSecond
        {
            get
            {
                if (_dealQuerySpeedInDealsPerSecond == default(decimal) && ExecutionTime.TotalSeconds > 0)
                {
                    DealQuerySpeedInDealsPerSecond = DealQuerySize/(decimal) ExecutionTime.TotalSeconds;
                }
                return _dealQuerySpeedInDealsPerSecond;
            }
            private set { _dealQuerySpeedInDealsPerSecond = value; }
        }

        public void Start()
        {
            QueryTimer.Start();
            _initialMemory = GC.GetTotalMemory(true);
        }

        public void Stop()
        {
            QueryTimer.Stop();
            ExecutionTime = QueryTimer.Elapsed;
            DealQuerySize = (GC.GetTotalMemory(true) - _initialMemory);
            DealQuerySizeFormatted = string.Format(new CultureInfo("en-US"), "{0:N0} K", DealQuerySize/1024);
        }
    }
}