using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    public static class ServerSearchExtensions
    {
        public static void Setup(this IServerSearchCriteria iServerSearchCriteria)
        {
            iServerSearchCriteria.Separator =
                iServerSearchCriteria.GetType().GetSeparatorValue(iServerSearchCriteria.Separator);
            iServerSearchCriteria.TradingServerList = new List<TradingServer>();
        }

        public static void ResolveImpl(this IServerSearchCriteria iServerSearchCriteria)
        {
            iServerSearchCriteria.SetUpServers();
        }

        public static void SetUpServersImpl(this IServerSearchCriteria iServerSearchCriteria)
        {
            if (iServerSearchCriteria.Servers == null) return;
            if (iServerSearchCriteria.Servers.Contains(iServerSearchCriteria.Separator))
            {
                List<string> servers =
                    iServerSearchCriteria.Servers.Split(iServerSearchCriteria.Separator).Distinct().ToList();
                servers.ForEach(iServerSearchCriteria.SafelyAddTradingServers);
                iServerSearchCriteria.Server = default(TradingServer);
            }
            else
            {
                iServerSearchCriteria.SafelyAddTradingServers(iServerSearchCriteria.Servers);
            }
        }

        public static void SafelyAddTradingServersImpl(this IServerSearchCriteria iServerSearchCriteria,
            string serverName)
        {
            try
            {
                iServerSearchCriteria.TradingServerList.Add(
                    (TradingServer) Enum.Parse(typeof (TradingServer), serverName));
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger(String.Format("{0} is not a valid trading server", serverName));
            }
        }
    }
}