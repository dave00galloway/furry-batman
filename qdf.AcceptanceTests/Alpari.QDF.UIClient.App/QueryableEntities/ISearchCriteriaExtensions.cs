using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    public static class SearchCriteriaExtensions //: ISearchCriteria
    {

        public static void Setup(this ISearchCriteria iSearchCriteria)
        {
            Configuration config =
                ConfigurationManager.OpenExeConfiguration(String.Format("{0}.dll",
                    iSearchCriteria.GetType().Assembly.GetName().Name.ToString(CultureInfo.InvariantCulture)));
            iSearchCriteria.Separator = App.GetSeperatorValue(config);
            iSearchCriteria.TradingServerList = new List<TradingServer>();
            iSearchCriteria.InstrumentList = new List<string>();            
        }

        public static void ResolveImpl(this ISearchCriteria iSearchCriteria)
        {
            //throw new NotImplementedException();
            iSearchCriteria.SetupSymbolsImpl();
            iSearchCriteria.SetUpServersImpl();

        }

        public static void SetupSymbolsImpl(this ISearchCriteria iSearchCriteria)
        {
            if (iSearchCriteria.Symbol == null) return;
            if (iSearchCriteria.Symbol.Contains(iSearchCriteria.Separator))
            {
                List<string> symbols = iSearchCriteria.Symbol.Split(iSearchCriteria.Separator).Distinct().ToList();
                symbols.ForEach(x => iSearchCriteria.InstrumentList.Add(x));
                iSearchCriteria.Instrument = null;
                //Symbol = null;
            }
            else
            {
                iSearchCriteria.Instrument = iSearchCriteria.Symbol;
                //Symbol = null;
            }
        }

        public static void SetUpServersImpl(this ISearchCriteria iSearchCriteria)
        {
            if (iSearchCriteria.Servers == null) return;
            if (iSearchCriteria.Servers.Contains(iSearchCriteria.Separator))
            {
                List<string> servers = iSearchCriteria.Servers.Split(iSearchCriteria.Separator).Distinct().ToList();
                servers.ForEach(iSearchCriteria.SafelyAddTradingServers);
                iSearchCriteria.Server = default(TradingServer);
            }
            else
            {
                iSearchCriteria.SafelyAddTradingServers(iSearchCriteria.Servers);
            }
        }

        public static void SafelyAddTradingServersImpl(this ISearchCriteria iSearchCriteria, string serverName)
        {
            try
            {
                iSearchCriteria.TradingServerList.Add((TradingServer)Enum.Parse(typeof(TradingServer), serverName));
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger(String.Format("{0} is not a valid trading server", serverName));
            }
        }
    }
}
