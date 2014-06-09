using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QDF.UIClient.Gui.Properties;

namespace Alpari.QDF.UIClient.Gui
{
    public partial class QuoteSearchAndRetrievalOptions : Form
    {

        public QuoteSearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup)
            
        {
            InitializeComponent();
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupEnvironmentList();
            SetupDataTypeList();
            symbolListBox.DataSource = ControlSetup.SymbolControl.SymbolListItems.Select(x => x.Symbol).ToList();

        }

        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }

        private void QuoteSearchAndRetrievalOptions_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void SetupEnvironmentList()
        {
            selectEnvironmentComboBox.SetupEnvironmentList(selectEnvironmentComboBox_SelectedIndexChanged, ControlSetup,
                Exporter);
        }

        private void SetupDataTypeList()
        {
            dataTypeComboBox.SetupDataTypeList(dataTypeComboBox_SelectedIndexChanged, ControlSetup);
        }

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            symbolListBox.SymbolSearchButton_Click(symbolSearchTextBox);
        }

        private void SetExportPathButton_Click(object sender, EventArgs e)
        {
            setExportPathSaveFileDialog.SetExportPathButton_Click();
        }

        private void SetExportPathSaveFileDialog_FileOk(object sender, CancelEventArgs e)
        {
            setExportPathSaveFileDialog.SetExportPathSaveFileDialog_FileOk(setExportPathTextBox, Exporter);
            setExportPathTextBox.Text = setExportPathSaveFileDialog.FileName;
            Exporter.ExportQuotesToCsv(setExportPathSaveFileDialog.FileName);
        }

        private void selectEnvironmentComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectEnvironmentComboBox.SelectEnvironmentComboBox_SelectedIndexChanged(Exporter);
        }

        private void dataTypeComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataTypeComboBox.DataTypeComboBox_SelectedIndexChanged(this);
        }

        private void quoteSearchButton_Click(object sender, EventArgs e)
        {
            try
            {
                displayTextBox.Text = Resources.SearchAndRetrievalOptions_FindDeals_Click_Setting_Up_Deal_Query;
                Exporter.RedisConnectionHelper.RedisQuoteSearches.GetQuoteData(SetupQuoteQuery());
                displayTextBox.Text = Exporter.RedisConnectionHelper.RetrievedQuotes.Any()
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

        private QuoteSearchCriteria SetupQuoteQuery()
        {
            var quoteQuery = new QuoteSearchCriteria
            {
                ConvertedStartTime = UiExtensions.SetDateTime(startDatePicker, startTimePicker),
                ConvertedEndTime = UiExtensions.SetDateTime(endDatePicker, endTimePicker)
            };

            //it's a bit daft having to set a delimited string when we already have a collection, but parsing the Instrument has been tested already
            if (symbolListBox.SelectedItems.Count > 0)
            {
                List<string> symbolList =
                    (from object selectedItem in symbolListBox.SelectedItems select selectedItem as string).ToList();
                quoteQuery.Symbol = String.Join(Program.SEPERATOR, symbolList);
            }

            return quoteQuery;
        }
    }
}
