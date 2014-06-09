using System.Collections.Generic;
using System.Linq;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    public static class SearchCriteriaExtensions //: ISearchCriteria
    {
        public static void Setup(this ISearchCriteria iSearchCriteria)
        {
            iSearchCriteria.Separator = iSearchCriteria.GetType().GetSeparatorValue(iSearchCriteria.Separator);
            iSearchCriteria.InstrumentList = new List<string>();
        }


        public static void ResolveImpl(this ISearchCriteria iSearchCriteria)
        {
            iSearchCriteria.SetupSymbols();
        }

        public static void SetupSymbolsImpl(this ISearchCriteria iSearchCriteria)
        {
            if (iSearchCriteria.Symbol == null) return;
            if (iSearchCriteria.Symbol.Contains(iSearchCriteria.Separator))
            {
                List<string> symbols = iSearchCriteria.Symbol.Split(iSearchCriteria.Separator).Distinct().ToList();
                symbols.ForEach(x => iSearchCriteria.InstrumentList.Add(x));
                iSearchCriteria.Instrument = null;
            }
            else
            {
                iSearchCriteria.Instrument = iSearchCriteria.Symbol;
            }
        }
    }
}