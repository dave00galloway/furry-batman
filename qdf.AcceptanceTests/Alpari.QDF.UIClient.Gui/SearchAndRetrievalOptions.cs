using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
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
        public SearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup)
        {
            InitializeComponent();
            symbolSearchButton.Enabled = false;
            findDealsButton.Enabled = false;
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupEnvironmentList();
            SetupDataTypeList();
            bookListBox.DataSource = ControlSetup.BookControl.BookList;
            symbolListBox.DataSource = ControlSetup.SymbolControl.SymbolListItems.Select(x=>x.Symbol).ToList();
            serverListBox.DataSource = ControlSetup.TradingServerControl.ServerList;
            symbolSearchButton.Enabled = true;
            findDealsButton.Enabled = true;
        }

        /// <summary>
        /// required for designer to function correctly with inheritance to descendant forms
        /// </summary>
        public SearchAndRetrievalOptions()
        {
            InitializeComponent();
        }

        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }

        private void SetupEnvironmentList()
        {
            selectEnvironmentComboBox.SetupEnvironmentList(selectEnvironmentComboBox_SelectedIndexChanged, ControlSetup,
                Exporter);
        }

        private void SetupDataTypeList()
        {
            dataTypeComboBox.SetupDataTypeList(dataTypeComboBox_SelectedIndexChanged,ControlSetup);
        }

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            symbolListBox.SymbolSearchButton_Click(symbolSearchTextBox);
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
                dealSearchCriteria.Symbol = String.Join(Program.SEPERATOR, symbolList);
            }

            if (serverListBox.SelectedItems.Count > 0)
            {
                List<string> serverList =
                    (from object selectedItem in serverListBox.SelectedItems select selectedItem as string).ToList();
                dealSearchCriteria.Servers = String.Join(Program.SEPERATOR, serverList);
            }

            if (dataTypeComboBox.SelectedItem == SupportedDataTypesControl.ECN_DEAL)
            {
                dealSearchCriteria.DealSource = SupportedDataTypesControl.ECN_DEAL;
            }
            return dealSearchCriteria;
        }

        private void SetExportPathButton_Click(object sender, EventArgs e)
        {
            setExportPathSaveFileDialog.SetExportPathButton_Click();
        }

        private void SetExportPathSaveFileDialog_FileOk(object sender, CancelEventArgs e)
        {
            setExportPathSaveFileDialog.SetExportPathSaveFileDialog_FileOk(setExportPathTextBox,Exporter);
        }

        private void selectEnvironmentComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectEnvironmentComboBox.SelectEnvironmentComboBox_SelectedIndexChanged(Exporter);
        }

        private void dataTypeComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataTypeComboBox.DataTypeComboBox_SelectedIndexChanged(this);
        }
    }
}