using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    /// <summary>
    ///     Extension of Deal to set up parameters for filtering query results
    /// </summary>
    [UsedImplicitly]
    public class DealSearchCriteria : Deal, ISearchCriteria
    {
        public DealSearchCriteria()
        {
            //Configuration config =
            //    ConfigurationManager.OpenExeConfiguration(String.Format("{0}.dll",
            //        GetType().Assembly.GetName().Name.ToString(CultureInfo.InvariantCulture)));
            //_separator = App.GetSeperatorValue(config);
            //TradingServerList = new List<TradingServer>();
            //InstrumentList = new List<string>();
            //_separator = ISearchCriteriaExtensions._separator;
            this.Setup();
        }

        public char Separator { get; set; }
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        //public List<Book> BookList { get; private set; }
        public List<string> InstrumentList { get; set; }
        public string Servers { get; set; }

        public List<TradingServer> TradingServerList { get; set; }

        /// <summary>
        ///     Synonym for Instrument
        /// </summary>
        public string Symbol { get; set; }

        /// <summary>
        ///     run through the properties that have been passed and use logic to set up additional properties, e.g. Lists
        /// </summary>
        public void Resolve()
        {
            ////SetupBook();
            //SetupSymbols();
            //SetUpServers(); 
            this.ResolveImpl();
            //this.Resolve();
        }

        public void SetupSymbols()
        {
            //if (Symbol == null) return;
            //if (Symbol.Contains(_separator))
            //{
            //    List<string> symbols = Symbol.Split(_separator).Distinct().ToList();
            //    symbols.ForEach(x => InstrumentList.Add(x));
            //    Instrument = null;
            //    //Symbol = null;
            //}
            //else
            //{
            //    Instrument = Symbol;
            //    //Symbol = null;
            //}
            //SearchCriteriaExtensions.SetupSymbols();
            //InstrumentList = SearchCriteriaExtensions.InstrumentList;
            //Instrument = SearchCriteriaExtensions.I
            this.SetupSymbolsImpl();
        }

        public void SetUpServers()
        {
            //if (Servers == null) return;
            //if (Servers.Contains(_separator))
            //{
            //    List<string> servers = Servers.Split(_separator).Distinct().ToList();
            //    servers.ForEach(SafelyAddTradingServers);
            //    Server = default(TradingServer);
            //}
            //else
            //{
            //    SafelyAddTradingServers(Servers);
            //}
            this.SetupSymbolsImpl();
        }

        public void SafelyAddTradingServers(string serverName)
        {
            //try
            //{
            //    TradingServerList.Add((TradingServer) Enum.Parse(typeof (TradingServer), serverName));
            //}
            //catch (Exception e)
            //{
            //    e.ConsoleExceptionLogger(String.Format("{0} is not a valid trading server", serverName));
            //}
            this.SafelyAddTradingServersImpl(serverName);
        }
    }
}