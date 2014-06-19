﻿using System;
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
        private decimal _dealQuerySpeedInDealsPerSecond;
        private string _dealQuerySpeedInDealsPerSecondFormatted;
        private TimeSpan _executionTime;
        private long _initialMemory;

        public PerformanceStats(RedisConnectionHelper redisConnectionHelper)
        {
            RedisConnectionHelper = redisConnectionHelper;
            QueryTimer = new Stopwatch();
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
                if (_dealQuerySpeedInBytesPerSecond == default(long) && ExecutionTime > 0)
                {
                    DealQuerySpeedInBytesPerSecond = DealQuerySize/ExecutionTime;
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
                    DealQuerySpeedInBytesPerSecondFormatted = string.Format(new CultureInfo("en-GB"),
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
                if (_dealQuerySpeedInDealsPerSecond == default(decimal) && ExecutionTime > 0)
                {
                    DealQuerySpeedInDealsPerSecond = DealCount/ExecutionTime;
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

        public void Start()
        {
            QueryTimer.Start();
            _initialMemory = GC.GetTotalMemory(true);
        }

        public void Stop()
        {
            QueryTimer.Stop();
            _executionTime = QueryTimer.Elapsed;
            DealQuerySize = (GC.GetTotalMemory(true) - _initialMemory);
            DealQuerySizeFormatted = string.Format(new CultureInfo("en-US"), "{0:N0} K", DealQuerySize/1024);
        }
    }
}