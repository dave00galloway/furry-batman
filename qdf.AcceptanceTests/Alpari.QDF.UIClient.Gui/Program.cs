using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;

namespace Alpari.QDF.UIClient.Gui
{
    static class Program
    {
        public const string REDIS_HOST = "redisHost";

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new SearchAndRetrievalOptions(new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST])),new ControlSetup(new TradingServerControl())));
        }
    }
}
