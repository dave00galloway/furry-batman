using System;
using System.Collections.Generic;
using System.Configuration;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.Annotations;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    /// <summary>
    ///     Extension of Deal to set up parameters for filtering query results
    /// </summary>
    [UsedImplicitly]
    public class DealSearchCriteria : Deal, ISearchCriteria, IServerSearchCriteria
    {
        private const string DEFAULT_START_TIME = "defaultStartTime";
        private const string DEFAULT_END_TIME = "defaultEndTime";

        public DealSearchCriteria()
        {
            SearchCriteriaExtensions.Setup(this);
            ServerSearchExtensions.Setup(this);
            DealSource = SupportedDataTypesControl.DEAL;
            // SetConvertedTimes();
        }

        [UsedImplicitly]
        public string StartTime { get; set; }
        [UsedImplicitly]
        public string EndTime { get; set; }

        /// <summary>
        ///     set to "Deal" i.e. ars deal by default.
        ///     can be set to "ecn-Deal" if needed
        ///     might need an interface for this, but it's only one property so just making a class member for now.
        /// </summary>
        public string DealSource { get; set; }

        public char Separator { get; set; }

        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        public List<string> InstrumentList { get; set; }

        /// <summary>
        ///     Synonym for Instrument
        /// </summary>
        public string Symbol { get; set; }

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

        public string Servers { get; set; }
        public List<TradingServer> TradingServerList { get; set; }

        public void SetUpServers()
        {
            this.SetUpServersImpl();
        }

        public void SafelyAddTradingServers(string serverName)
        {
            this.SafelyAddTradingServersImpl(serverName);
        }

        public void SetConvertedTimes()
        {
            if (ConvertedStartTime != default(DateTime)) return;
            string start = StartTime ?? ConfigurationManager.AppSettings[DEFAULT_START_TIME];
            string end = EndTime ?? ConfigurationManager.AppSettings[DEFAULT_END_TIME];
            ConvertedStartTime = start.GetTimeFromShortCode();
            ConvertedEndTime = end.GetTimeFromShortCode(ConvertedStartTime);
        }

        /// <summary>
        /// use this to deonte "Deal" or "BookLessDeal"
        /// </summary>
        public string DealType { get; [UsedImplicitly] set; }
    }
}