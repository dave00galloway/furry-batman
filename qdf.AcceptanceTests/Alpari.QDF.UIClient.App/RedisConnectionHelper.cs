using Alpari.QDF.Domain;
using BookSleeve;
using System.Collections.Generic;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    ///     warning - repeated this code in qdf.AcceptanceTests.Helpers
    /// </summary>
    public class RedisConnectionHelper
    {
        private RedisDealSearches _redisDealSearches;
        private RedisQuoteSearches _redisQuoteSearches;
        private PerformanceStats _performanceStats;

        public RedisConnectionHelper(string redisHost)
        {
            RedisHost = redisHost;
            Connection = new RedisConnection(RedisHost);
            Connection.Open();
            _redisDealSearches = new RedisDealSearches(this);
            _redisQuoteSearches = new RedisQuoteSearches(this);
            _performanceStats = new PerformanceStats(this);
        }

        public RedisDataStore DealsStore { get; set; }
        public List<Deal> RetrievedDeals { get; set; }
        public RedisDataStore QuoteStore { get; set; }
        public List<PriceQuote> RetrievedQuotes { get; set; }
        public RedisConnection Connection { get; private set; }
        public string RedisHost { get; private set; }

        public RedisDealSearches RedisDealSearches
        {
            get { return _redisDealSearches; }
        }

        public RedisQuoteSearches RedisQuoteSearches
        {
            get { return _redisQuoteSearches; }
        }

        public PerformanceStats PerformanceStats
        {
            get { return _performanceStats; }
        }

        /// <summary>
        /// bit hacky, should really be usingthe exporter and just reset the whole connection
        /// </summary>
        public void ResetPerformanceStats()
        {
            DealsStore = null;
            if (RetrievedDeals != null)
            {
                RetrievedDeals.Clear();
            }
            
            QuoteStore = null;
            if (RetrievedQuotes != null)
            {
                RetrievedQuotes.Clear();
            }

            _redisDealSearches = new RedisDealSearches(this);
            _redisQuoteSearches = new RedisQuoteSearches(this);
            _performanceStats = new PerformanceStats(this);
        }
    }
}