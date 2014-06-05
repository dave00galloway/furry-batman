using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QDF.UIClient.Gui.Properties;
using System;
using System.Linq;
using System.Windows.Forms;

namespace Alpari.QDF.UIClient.Gui
{
    public partial class SearchAndRetrievalOptions : Form
    {
        private const string Seperator = ",";

        public SearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup)
        {
            InitializeComponent();
            SymbolSearchButton.Enabled = false;
            FindDealsButton.Enabled = false;
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupBookListBox();
            SetupSymbolListBox();
            SetupServerListBox();
            SymbolSearchButton.Enabled = true;
            FindDealsButton.Enabled = true;
        }

        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }

        private void SetupBookListBox()
        {
            foreach (string book in ControlSetup.BookControl.BookList)
            {
                BookListBox.Items.Add(book);
            }
        }

        private void SetupSymbolListBox()
        {
            foreach (SymbolListItem symbol in ControlSetup.SymbolControl.SymbolListItems)
            {
                SymbolListBox.Items.Add(symbol.Symbol);
            }
        }

        private void SetupServerListBox()
        {
            foreach (string server in ControlSetup.TradingServerControl.ServerList)
            {
                ServerListBox.Items.Add(server);
            }
        }

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            int pos = SymbolSearchTextBox.SelectionStart;
            string typed = SymbolSearchTextBox.Text.Substring(0, pos);
            SymbolListBox.SearchAndScrollList(typed);
        }

        private void FindDeals_Click(object sender, EventArgs e)
        {
            Display.Text = Resources.SearchAndRetrievalOptions_FindDeals_Click_Setting_Up_Deal_Query;
            Exporter.RedisConnectionHelper.GetDealData(SetupDealQuery());
            Display.Text = Exporter.RedisConnectionHelper.RetrievedDeals.Any() ? Resources.SearchAndRetrievalOptions_FindDeals_Click_Ready_to_export_data : Resources.SearchAndRetrievalOptions_FindDeals_Click_No_Data_Found;
            
        }

        private DealSearchCriteria SetupDealQuery()
        {
            var dealSearchCriteria = new DealSearchCriteria
            {
                ConvertedStartTime = UiExtensions.SetDateTime(StartDatePicker, StartTimePicker),
                ConvertedEndTime = UiExtensions.SetDateTime(EndDatePicker, EndTimePicker)
            };
            if (BookListBox.SelectedItems.Count > 0)
            {
                dealSearchCriteria.Book = (Book) Enum.Parse(typeof (Book), (string) BookListBox.SelectedItems[0]);
            }
            //it's a bit daft having to set a delimited string when we already have a collection, but parsing the Instrument has been tested already
            if (SymbolListBox.SelectedItems.Count > 0)
            {
                var symbolList =
                    (from object selectedItem in SymbolListBox.SelectedItems select selectedItem as string).ToList();
                dealSearchCriteria.Symbol = String.Join(Seperator,symbolList);
            }

            if (ServerListBox.SelectedItems.Count > 0)
            {
                var serverList =
                    (from object selectedItem in ServerListBox.SelectedItems select selectedItem as string).ToList();
                dealSearchCriteria.Servers = String.Join(Seperator, serverList);                
            }
            //dealSearchCriteria.Resolve();
            return dealSearchCriteria;
        }

        private void SetExportPathButton_Click(object sender, EventArgs e)
        {
            SetExportPathSaveFileDialog.ShowDialog();
        }

        private void SetExportPathSaveFileDialog_FileOk(object sender, System.ComponentModel.CancelEventArgs e)
        {
            SetExportPathTextBox.Text = SetExportPathSaveFileDialog.FileName;
            Exporter.ExportDealsToCsv(SetExportPathSaveFileDialog.FileName);
        }
    }
}