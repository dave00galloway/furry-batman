using System;
using System.Collections.Generic;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    [UsedImplicitly]
    public class QuoteSearchCriteria : PriceQuote, ISearchCriteria
    {
        public QuoteSearchCriteria()
        {
            SearchCriteriaExtensions.Setup(this);
        }

        public char Separator { get; set; }
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        public List<string> InstrumentList { get; set; }
        public string Symbol { get; set; }

        public void Resolve()
        {
            this.ResolveImpl();
        }

        public void SetupSymbols()
        {
            this.SetupSymbolsImpl();
        }
    }
}
