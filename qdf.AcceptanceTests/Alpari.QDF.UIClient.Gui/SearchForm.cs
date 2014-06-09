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
    /// <summary>
    /// attempt at using iunheritance to define a common UI to avoid repetetive code  and UI setup, but caused problems in the designer
    /// </summary>
    public partial class SearchForm : Form
    {
        protected SearchForm(Exporter exporter, ControlSetup controlSetup)
        {
            InitializeComponent();
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupEnvironmentList();
            SetupDataTypeList();
            SetupSymbolListBox();
        }

        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }
        public string FormDataType { get; set; }

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            int pos = symbolSearchTextBox.SelectionStart;
            string typed = symbolSearchTextBox.Text.Substring(0, pos);
            symbolListBox.SearchAndScrollList(typed);
        }

        private void SetupEnvironmentList()
        {
            selectEnvironmentComboBox.SelectedIndexChanged -= selectEnvironmentComboBox_SelectedIndexChanged;
            selectEnvironmentComboBox.DataSource =
                ControlSetup.EnvironmentControl.EnvironmentListItems.Select(x => x.Key).ToList();
            string setThis = ControlSetup.EnvironmentControl.GetInitialValue(Exporter.RedisConnectionHelper.RedisHost);
            selectEnvironmentComboBox.SelectedItem = setThis;
            selectEnvironmentComboBox.SelectedIndexChanged += selectEnvironmentComboBox_SelectedIndexChanged;
        }

        private void SetupDataTypeList()
        {
            dataTypeComboBox.SelectedIndexChanged -= dataTypeComboBox_SelectedIndexChanged;
            dataTypeComboBox.DataSource = ControlSetup.SupportedDataTypesControl.Types;
            if (FormDataType == null)
            {
                dataTypeComboBox.SelectedItem = ControlSetup.SupportedDataTypesControl.Default;
            }
            dataTypeComboBox.SelectedIndexChanged += dataTypeComboBox_SelectedIndexChanged;
        }

        private void SetupSymbolListBox()
        {
            foreach (SymbolListItem symbol in ControlSetup.SymbolControl.SymbolListItems)
            {
                symbolListBox.Items.Add(symbol.Symbol);
            }
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

        private void dataTypeComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Program.SwitchForm(this, dataTypeComboBox.SelectedItem.ToString());
        }
    }
}
