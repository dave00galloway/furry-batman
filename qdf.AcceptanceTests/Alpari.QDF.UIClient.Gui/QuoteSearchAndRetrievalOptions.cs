using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;

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
