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

        public static string CurrentFormDataType { get; set; }

        public static void SwitchForm(Form form, string formName)
        {
            switch (formName)
            {
                case SupportedDataTypesControl.DEAL:
                    SearchAndRetrievalOptions searchAndRetrievalOptions = SearchAndRetrievalOptionsForm();
                    CurrentFormDataType = formName;
                    searchAndRetrievalOptions.Show();
                    form.Hide();
                    break;

                case SupportedDataTypesControl.PRICE_QUOTE:
                    QuoteSearchAndRetrievalOptions quoteSearchForm = QuoteSearchAndRetrievalOptionsForm();
                    CurrentFormDataType = formName;
                    quoteSearchForm.Show();
                    form.Hide();
                    break;

                default:
                    throw new ArgumentException(
                        Resources.SearchAndRetrievalOptions_dataTypeComboBox_SelectedIndexChanged_not_supported,
                        formName);
            }
        }

        private static SearchAndRetrievalOptions SearchAndRetrievalOptionsForm()
        {
            return new SearchAndRetrievalOptions(
                new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST])),
                ControlSetup());
        }

        public static ControlSetup ControlSetup()
        {
            return new ControlSetup(new TradingServerControl(), new BookControl(), new SymbolControl(),
                new EnvironmentControl(ReferenceData.Instance), new SupportedDataTypesControl());
        }

        private static QuoteSearchAndRetrievalOptions QuoteSearchAndRetrievalOptionsForm()
        {
            return
                new QuoteSearchAndRetrievalOptions(
                    new Exporter(new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST])),
                    ControlSetup());
        }
    }
}