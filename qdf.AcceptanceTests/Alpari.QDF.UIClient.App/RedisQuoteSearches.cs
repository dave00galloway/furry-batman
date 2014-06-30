using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;

namespace Alpari.QDF.UIClient.App
{
    public class RedisQuoteSearches
    {
        private readonly RedisConnectionHelper _redisConnectionHelper;
        public IEnumerable<LevelQuote> TotalRetrievedQuotes { get; private set; }

        public RedisQuoteSearches(RedisConnectionHelper redisConnectionHelper)
        {
            _redisConnectionHelper = redisConnectionHelper;
            TotalRetrievedQuotes = new List<LevelQuote>();
        }

        public void GetQuoteData(QuoteSearchCriteria quoteSearchCriteria)
        {
            //set up the search parameters
            quoteSearchCriteria.Resolve();

            //get the deals for the date range
            TotalRetrievedQuotes = GetQuotesForDateRange(quoteSearchCriteria.ConvertedStartTime,
                quoteSearchCriteria.ConvertedEndTime);

            //filter the results using the search parameters
            _redisConnectionHelper.RetrievedQuotes = FilterQuotesBySearchCriteria(TotalRetrievedQuotes, quoteSearchCriteria);
        }

        private List<LevelQuote> FilterQuotesBySearchCriteria(IEnumerable<LevelQuote> quotes,
            QuoteSearchCriteria quoteSearchCriteria)
        {
            quotes = FilterQuotesBySymbol(quotes, quoteSearchCriteria);
            return quotes.ToList();
        }

        private IEnumerable<LevelQuote> FilterQuotesBySymbol(IEnumerable<LevelQuote> quotes, QuoteSearchCriteria quoteSearchCriteria)
        {
            if (quoteSearchCriteria.Instrument != null)
            {
                quotes = quotes.Where(x => x.Instrument == quoteSearchCriteria.Instrument);
            }
            else if (quoteSearchCriteria.InstrumentList.Count > 0)
            {
                quotes = quotes.Where(x => quoteSearchCriteria.InstrumentList.Contains(x.Instrument));
            }
            return quotes;
        }

        private IEnumerable<LevelQuote> GetQuotesForDateRange(DateTime convertedStartTime, DateTime convertedEndTime)
        {
            _redisConnectionHelper.QuoteStore = new RedisDataStore(_redisConnectionHelper.Connection,
                new SortedSetBasedStorageStrategy(_redisConnectionHelper.Connection, new ProtoBufSerializer()));
            IEnumerable<LevelQuote> priceQuotes = _redisConnectionHelper.QuoteStore.Load<LevelQuote>(KeyConfig.KeyNamespaces.PriceQuote,
                convertedStartTime, convertedEndTime, TimeSpan.FromMinutes(10));
            return priceQuotes;
        }
    }
}