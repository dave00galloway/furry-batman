using System;
using System.Configuration;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QualityAssurance.RefData;

namespace Alpari.QDF.UIClient.Gui
{
    internal static class Program
    {
        public const string REDIS_HOST = "redisHost";

        /// <summary>
        ///     The main entry point for the application.
        /// </summary>
        [STAThread]
        private static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(
                new SearchAndRetrievalOptions(
                    new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST])),
                    new ControlSetup(new TradingServerControl(), new BookControl(), new SymbolControl(), new EnvironmentControl(ReferenceData.Instance))));
        }
    }
}