using System;
using System.Configuration;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QDF.UIClient.Gui.Properties;
using Alpari.QualityAssurance.RefData;

namespace Alpari.QDF.UIClient.Gui
{
    internal static class Program
    {
        public const string REDIS_HOST = "redisHost";
        public const string SEPERATOR = ",";

        /// <summary>
        ///     The main entry point for the application.
        /// </summary>
        [STAThread]
        private static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(
                SearchAndRetrievalOptionsForm());
        }

        public static string CurrentFormDataType { get; private set; }

        public static void SwitchForm(Form form, string formName)
        {
            CurrentFormDataType = formName;
            switch (formName)
            {
                case SupportedDataTypesControl.DEAL:
                    SearchAndRetrievalOptions searchAndRetrievalOptions = SearchAndRetrievalOptionsForm();                    
                    searchAndRetrievalOptions.Show();
                    break;

                case SupportedDataTypesControl.PRICE_QUOTE:
                    QuoteSearchAndRetrievalOptions quoteSearchForm = QuoteSearchAndRetrievalOptionsForm();                    
                    quoteSearchForm.Show();
                    break;

                case SupportedDataTypesControl.ECN_DEAL:
                    EcnDealsSearchAndRetrievalOptions ecnSearchForm = EcnDealsSearchAndRetrievalOptions();
                    ecnSearchForm.Show();
                    break;

                default:
                    throw new ArgumentException(
                        Resources.SearchAndRetrievalOptions_dataTypeComboBox_SelectedIndexChanged_not_supported,
                        formName);
            }
            form.Hide();
        }

        private static SearchAndRetrievalOptions SearchAndRetrievalOptionsForm()
        {
            return new SearchAndRetrievalOptions(
                Exporter(),
                ControlSetup());
        }

        private static QuoteSearchAndRetrievalOptions QuoteSearchAndRetrievalOptionsForm()
        {
            return
                new QuoteSearchAndRetrievalOptions(
                    new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST])),
                    ControlSetup());
        }

        private static EcnDealsSearchAndRetrievalOptions EcnDealsSearchAndRetrievalOptions()
        {
            return new EcnDealsSearchAndRetrievalOptions(Exporter(), ControlSetup());
        }

        public static Exporter Exporter()
        {
            return new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]));
        }

        private static ControlSetup ControlSetup()
        {
            return new ControlSetup(new TradingServerControl(), new BookControl(), new SymbolControl(),
                new EnvironmentControl(ReferenceData.Instance), new SupportedDataTypesControl());
        }
    }
}