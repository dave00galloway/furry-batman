using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    /// Extension of Deal to set up parameters for filtering query results
    /// </summary>
    [UsedImplicitly]
    public class DealSearchCriteria : Deal
    {
        public const string LIST_SEPERATOR = "listSeperator";
        public const string BEHAVIOUR_SECTION_NAME = "Behaviour";
        private readonly char _separator;

        public DealSearchCriteria()
        {
            Configuration config =
                ConfigurationManager.OpenExeConfiguration(String.Format("{0}.dll",
                    GetType().Assembly.GetName().Name.ToString(CultureInfo.InvariantCulture)));
            var section = (AppSettingsSection)config.GetSection(BEHAVIOUR_SECTION_NAME);
            _separator = Convert.ToChar(section.Settings[LIST_SEPERATOR].Value);
            TradingServerList = new List<TradingServer>();
            InstrumentList = new List<string>();
        }

        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        public List<Book> BookList { get; private set; }
        public List<string> InstrumentList { get; private set; }
        public string Servers { get; set; }
        public List<TradingServer> TradingServerList { get; private set; }
        /// <summary>
        /// Synonym for Instrument
        /// </summary>
        public string Symbol { get; set; }

        /// <summary>
        /// run through the properties that have been passed and use logic to set up additional properties, e.g. Lists
        /// </summary>
        public void Resolve()
        {
            SetUpServers();
            SetupSymbols();
        }

        private void SetupSymbols()
        {
            if (Symbol == null) return;
            if (Symbol.Contains(_separator))
            {
                var symbols = Symbol.Split(_separator).Distinct().ToList();
                symbols.ForEach(x => InstrumentList.Add(x));
                Instrument = null;
                Symbol = null;
            }
            else
            {
                Instrument = Symbol;
            }
        }

        private void SetUpServers()
        {
            if (Servers != default (string) && Servers.Contains(_separator))
            {
                var servers = Servers.Split(_separator).Distinct().ToList();
                servers.ForEach(SafelyAddTradingServers);
                Server = default(TradingServer);
            }
        }

        private void SafelyAddTradingServers(string serverName)
        {
            try
            {
                TradingServerList.Add((TradingServer)Enum.Parse(typeof(TradingServer), serverName));
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger(String.Format("{0} is not a valid trading server",serverName));
            }
        }
    }
}
