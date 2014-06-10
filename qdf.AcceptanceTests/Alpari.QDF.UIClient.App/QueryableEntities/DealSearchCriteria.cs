using System;
using System.Collections.Generic;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.Annotations;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    /// <summary>
    ///     Extension of Deal to set up parameters for filtering query results
    /// </summary>
    [UsedImplicitly]
    public class DealSearchCriteria : Deal, ISearchCriteria, IServerSearchCriteria
    {
        public DealSearchCriteria()
        {
            SearchCriteriaExtensions.Setup(this);
            ServerSearchExtensions.Setup(this);
            DealSource = ControlHelpers.SupportedDataTypesControl.DEAL;
        }

        public char Separator { get; set; }
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        public List<string> InstrumentList { get; set; }
        public string Servers { get; set; }
        public List<TradingServer> TradingServerList { get; set; }
        /// <summary>
        ///     Synonym for Instrument
        /// </summary>
        public string Symbol { get; set; }

        /// <summary>
        /// set to "Deal" i.e. ars deal by default.
        /// can be set to "ecn-Deal" if needed
        /// might need an interface for this, but it's only one property so just making a class member for now.
        /// 
        /// </summary>
        public string DealSource { get; set; }

        /// <summary>
        ///     run through the properties that have been passed and use logic to set up additional properties, e.g. Lists
        /// </summary>
        public void Resolve()
        {
            SearchCriteriaExtensions.ResolveImpl(this);
            ServerSearchExtensions.ResolveImpl(this);
        }

        public void SetupSymbols()
        {
            this.SetupSymbolsImpl();
        }

        public void SetUpServers()
        {
            this.SetUpServersImpl();
        }

        public void SafelyAddTradingServers(string serverName)
        {
            this.SafelyAddTradingServersImpl(serverName);
        }
    }
}