using System;
using System.Diagnostics;

namespace Alpari.QDF.UIClient.App
{
    public class PerformanceStats
    {
        public TimeSpan ExecutionTime { get; private set; }
        private RedisConnectionHelper RedisConnectionHelper { get; set; }
        private Stopwatch QueryTimer { get; set; }

        public PerformanceStats(RedisConnectionHelper redisConnectionHelper)
        {
            RedisConnectionHelper = redisConnectionHelper;
            QueryTimer = new Stopwatch();
        }

        public void Start()
        {
            QueryTimer.Start();
        }

        public void Stop()
        {
            QueryTimer.Stop();
            ExecutionTime = QueryTimer.Elapsed;
        }
    }
}