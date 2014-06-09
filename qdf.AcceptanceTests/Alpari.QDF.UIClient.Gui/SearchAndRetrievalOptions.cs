using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows.Forms;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QDF.UIClient.Gui.Properties;

namespace Alpari.QDF.UIClient.Gui
{
    public partial class SearchAndRetrievalOptions : Form
    {
        private const string Seperator = ",";

        public SearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup)
        {
            InitializeComponent();
            symbolSearchButton.Enabled = false;
            findDealsButton.Enabled = false;
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupEnvironmentList();
            SetupBookListBox();
            SetupSymbolListBox();
            SetupServerListBox();
            symbolSearchButton.Enabled = true;
            findDealsButton.Enabled = true;
        }

        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }

        private void SetupEnvironmentList()
        {
            selectEnvironmentComboBox.SelectedIndexChanged -= selectEnvironmentComboBox_SelectedIndexChanged;
            selectEnvironmentComboBox.DataSource =
                ControlSetup.EnvironmentControl.EnvironmentListItems.Select(x => x.Key).ToList();
            var setThis = ControlSetup.EnvironmentControl.GetInitialValue(Exporter.RedisConnectionHelper.RedisHost);
            selectEnvironmentComboBox.SelectedItem = setThis;
            selectEnvironmentComboBox.SelectedIndexChanged += selectEnvironmentComboBox_SelectedIndexChanged;

        }

        private void SetupBookListBox()
        {
            foreach (string book in ControlSetup.BookControl.BookList)
            {
                bookListBox.Items.Add(book);
            }
        }

        private void SetupSymbolListBox()
        {
            foreach (SymbolListItem symbol in ControlSetup.SymbolControl.SymbolListItems)
            {
                symbolListBox.Items.Add(symbol.Symbol);
            }
        }

        private void SetupServerListBox()
        {
            foreach (string server in ControlSetup.TradingServerControl.ServerList)
            {
                serverListBox.Items.Add(server);
            }
        }

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            int pos = symbolSearchTextBox.SelectionStart;
            string typed = symbolSearchTextBox.Text.Substring(0, pos);
            symbolListBox.SearchAndScrollList(typed);
        }

        private void FindDeals_Click(object sender, EventArgs e)
        {
            try
            {
                displayTextBox.Text = Resources.SearchAndRetrievalOptions_FindDeals_Click_Setting_Up_Deal_Query;
                Exporter.RedisConnectionHelper.RedisDealSearches.GetDealData(SetupDealQuery());
                displayTextBox.Text = Exporter.RedisConnectionHelper.RetrievedDeals.Any()
                    ? Resources.SearchAndRetrievalOptions_FindDeals_Click_Ready_to_export_data
                    : Resources.SearchAndRetrievalOptions_FindDeals_Click_No_Data_Found;
            }
            catch (Exception ex)
            {
                displayTextBox.Text =
                    Resources.SearchAndRetrievalOptions_FindDeals_Click_try_closing_and_reopening_the_client +
                    ex.Message;
            }
        }

        private DealSearchCriteria SetupDealQuery()
        {
            var dealSearchCriteria = new DealSearchCriteria
            {
                ConvertedStartTime = UiExtensions.SetDateTime(startDatePicker, startTimePicker),
                ConvertedEndTime = UiExtensions.SetDateTime(endDatePicker, endTimePicker)
            };
            if (bookListBox.SelectedItems.Count > 0)
            {
                dealSearchCriteria.Book = (Book) Enum.Parse(typeof (Book), (string) bookListBox.SelectedItems[0]);
            }
            //it's a bit daft having to set a delimited string when we already have a collection, but parsing the Instrument has been tested already
            if (symbolListBox.SelectedItems.Count > 0)
            {
                List<string> symbolList =
                    (from object selectedItem in symbolListBox.SelectedItems select selectedItem as string).ToList();
                dealSearchCriteria.Symbol = String.Join(Seperator, symbolList);
            }

            if (serverListBox.SelectedItems.Count > 0)
            {
                List<string> serverList =
                    (from object selectedItem in serverListBox.SelectedItems select selectedItem as string).ToList();
                dealSearchCriteria.Servers = String.Join(Seperator, serverList);
            }
            //dealSearchCriteria.Resolve();
            return dealSearchCriteria;
        }

        private void SetExportPathButton_Click(object sender, EventArgs e)
        {
            setExportPathSaveFileDialog.ShowDialog();
        }

        private void SetExportPathSaveFileDialog_FileOk(object sender, CancelEventArgs e)
        {
            setExportPathTextBox.Text = setExportPathSaveFileDialog.FileName;
            Exporter.ExportDealsToCsv(setExportPathSaveFileDialog.FileName);
        }

        private void selectEnvironmentComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Exporter.SwitchRedisConnection(selectEnvironmentComboBox.SelectedItem.ToString());
        }
    }
}