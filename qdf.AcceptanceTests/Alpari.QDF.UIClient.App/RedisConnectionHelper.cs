using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using BookSleeve;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    ///     warning - repeated this code in qdf.AcceptanceTests.Helpers
    /// </summary>
    public class RedisConnectionHelper
    {
        private readonly RedisDealSearches _redisDealSearches;
        private readonly RedisQuoteSearches _redisQuoteSearches;

        public RedisConnectionHelper(string redisHost)
        {
            RedisHost = redisHost;
            Connection = new RedisConnection(RedisHost);
            Connection.Open();
            _redisDealSearches = new RedisDealSearches(this);
            _redisQuoteSearches = new RedisQuoteSearches(this);
        }

        public RedisDataStore DealsStore { get; set; }
        public List<Deal> RetrievedDeals { get; set; }
        public RedisDataStore QuoteStore { get; set; }
        public List<PriceQuote> RetrievedQuotes { get; set; }
        public RedisConnection Connection { get; set; }
        public string RedisHost { get; private set; }

        public RedisDealSearches RedisDealSearches
        {
            get { return _redisDealSearches; }
        }

        public RedisQuoteSearches RedisQuoteSearches
        {
            get { return _redisQuoteSearches; }
        }
    }
}