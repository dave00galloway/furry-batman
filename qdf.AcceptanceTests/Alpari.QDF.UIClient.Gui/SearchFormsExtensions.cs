using System;
using System.Linq;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;

namespace Alpari.QDF.UIClient.Gui
{
    /// <summary>
    ///     attempt at minimising code duplication with inheritance not working correctly in the forms
    /// </summary>
    public static class SearchFormsExtensions
    {
        public static void SetupEnvironmentList(this ComboBox comboBox, EventHandler eventHandler,
            ControlSetup controlSetup, Exporter exporter)
        {
            comboBox.SelectedIndexChanged -= eventHandler;
            comboBox.DataSource =
                controlSetup.EnvironmentControl.EnvironmentListItems.Select(x => x.Key).ToList();
            string setThis = controlSetup.EnvironmentControl.GetInitialValue(exporter.RedisConnectionHelper.RedisHost);
            comboBox.SelectedItem = setThis;
            comboBox.SelectedIndexChanged += eventHandler;
        }

        public static void SetupDataTypeList(this ComboBox comboBox, EventHandler eventHandler,
            ControlSetup controlSetup)
        {
            comboBox.SelectedIndexChanged -= eventHandler;
            comboBox.DataSource = controlSetup.SupportedDataTypesControl.Types;
            if (Program.CurrentFormDataType == null)
            {
                comboBox.SelectedItem = controlSetup.SupportedDataTypesControl.Default;
            }
            else
            {
                comboBox.SelectedItem = Program.CurrentFormDataType;
            }
            comboBox.SelectedIndexChanged += eventHandler;
        }

        public static void SymbolSearchButton_Click(this ListBox listBox, TextBox textBox)
        {
            int pos = textBox.SelectionStart;
            string typed = textBox.Text.Substring(0, pos);
            listBox.SearchAndScrollList(typed);            
        }

        public static void SetExportPathButton_Click(this SaveFileDialog saveFileDialog)
        {
            saveFileDialog.ShowDialog();
        }

        public static void SetExportPathSaveFileDialog_FileOk(this SaveFileDialog saveFileDialog, TextBox textBox, Exporter exporter)
        {
            textBox.Text = saveFileDialog.FileName;
            exporter.ExportDealsToCsv(saveFileDialog.FileName);            
        }

        public static void SelectEnvironmentComboBox_SelectedIndexChanged(this ComboBox environmentComboBox, Exporter exporter)
        {
            exporter.SwitchRedisConnection(environmentComboBox.SelectedItem.ToString());
        }

        public static void DataTypeComboBox_SelectedIndexChanged(this ComboBox comboBox, Form form)
        {
            Program.SwitchForm(form,comboBox.SelectedItem.ToString());
        }

        public static void ShowQueryStatsCheckBox_CheckedChanged(this CheckBox checkBox, RichTextBox richTextBox)
        {
            switch (checkBox.CheckState)
            {
                case CheckState.Checked:
                    richTextBox.Text = "";
                    richTextBox.Visible = true;
                    richTextBox.AddContextMenu();
                    break;
                default:
                    richTextBox.Text = "";
                    richTextBox.Visible = false;
                    richTextBox.ContextMenu = new ContextMenu();
                    break;
            }
        }

        public static void ShowQueryStats(this RichTextBox richTextBox, PerformanceStats performanceStats, string selectedItem)
        {
            richTextBox.Lines = performanceStats.GetStats(selectedItem);
        }
    }
}