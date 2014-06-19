using System.Windows.Forms;

namespace Alpari.QDF.UIClient.Gui
{
    partial class QuoteSearchAndRetrievalOptions 
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.symbolLabel = new System.Windows.Forms.Label();
            this.symbolListBox = new System.Windows.Forms.ListBox();
            this.symbolSearchTextBox = new System.Windows.Forms.TextBox();
            this.symbolSearchLabel = new System.Windows.Forms.Label();
            this.symbolSearchButton = new System.Windows.Forms.Button();
            this.startDatePicker = new System.Windows.Forms.DateTimePicker();
            this.endDatePicker = new System.Windows.Forms.DateTimePicker();
            this.startDateLabel = new System.Windows.Forms.Label();
            this.endDateLabel = new System.Windows.Forms.Label();
            this.endTimeLabel = new System.Windows.Forms.Label();
            this.startTimeLabel = new System.Windows.Forms.Label();
            this.endTimePicker = new System.Windows.Forms.DateTimePicker();
            this.startTimePicker = new System.Windows.Forms.DateTimePicker();
            this.displayTextBox = new System.Windows.Forms.TextBox();
            this.setExportPathButton = new System.Windows.Forms.Button();
            this.setExportPathTextBox = new System.Windows.Forms.TextBox();
            this.setExportPathSaveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.selectEnvironmentComboBox = new System.Windows.Forms.ComboBox();
            this.dataTypeLabel = new System.Windows.Forms.Label();
            this.dataTypeComboBox = new System.Windows.Forms.ComboBox();
            this.environmentLabel = new System.Windows.Forms.Label();
            this.quoteSearchButton = new System.Windows.Forms.Button();
            this.statsRichTextBox = new System.Windows.Forms.RichTextBox();
            this.showQueryStatsCheckBox = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // symbolLabel
            // 
            this.symbolLabel.AutoSize = true;
            this.symbolLabel.Location = new System.Drawing.Point(168, 141);
            this.symbolLabel.Name = "symbolLabel";
            this.symbolLabel.Size = new System.Drawing.Size(52, 13);
            this.symbolLabel.TabIndex = 5;
            this.symbolLabel.Text = "Symbol(s)";
            // 
            // symbolListBox
            // 
            this.symbolListBox.FormattingEnabled = true;
            this.symbolListBox.Location = new System.Drawing.Point(171, 157);
            this.symbolListBox.Name = "symbolListBox";
            this.symbolListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.symbolListBox.Size = new System.Drawing.Size(120, 394);
            this.symbolListBox.TabIndex = 6;
            // 
            // symbolSearchTextBox
            // 
            this.symbolSearchTextBox.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.symbolSearchTextBox.Location = new System.Drawing.Point(171, 75);
            this.symbolSearchTextBox.Name = "symbolSearchTextBox";
            this.symbolSearchTextBox.Size = new System.Drawing.Size(120, 20);
            this.symbolSearchTextBox.TabIndex = 7;
            // 
            // symbolSearchLabel
            // 
            this.symbolSearchLabel.AutoSize = true;
            this.symbolSearchLabel.Location = new System.Drawing.Point(171, 55);
            this.symbolSearchLabel.Name = "symbolSearchLabel";
            this.symbolSearchLabel.Size = new System.Drawing.Size(75, 13);
            this.symbolSearchLabel.TabIndex = 8;
            this.symbolSearchLabel.Text = "SymbolSearch";
            // 
            // symbolSearchButton
            // 
            this.symbolSearchButton.Location = new System.Drawing.Point(171, 101);
            this.symbolSearchButton.Name = "symbolSearchButton";
            this.symbolSearchButton.Size = new System.Drawing.Size(120, 23);
            this.symbolSearchButton.TabIndex = 9;
            this.symbolSearchButton.Text = "Search Symbols";
            this.symbolSearchButton.UseVisualStyleBackColor = true;
            this.symbolSearchButton.Click += new System.EventHandler(this.SymbolSearchButton_Click);
            // 
            // startDatePicker
            // 
            this.startDatePicker.Location = new System.Drawing.Point(445, 72);
            this.startDatePicker.Name = "startDatePicker";
            this.startDatePicker.Size = new System.Drawing.Size(116, 20);
            this.startDatePicker.TabIndex = 10;
            // 
            // endDatePicker
            // 
            this.endDatePicker.Location = new System.Drawing.Point(445, 117);
            this.endDatePicker.Name = "endDatePicker";
            this.endDatePicker.Size = new System.Drawing.Size(116, 20);
            this.endDatePicker.TabIndex = 11;
            // 
            // startDateLabel
            // 
            this.startDateLabel.AutoSize = true;
            this.startDateLabel.Location = new System.Drawing.Point(442, 55);
            this.startDateLabel.Name = "startDateLabel";
            this.startDateLabel.Size = new System.Drawing.Size(52, 13);
            this.startDateLabel.TabIndex = 12;
            this.startDateLabel.Text = "StartDate";
            // 
            // endDateLabel
            // 
            this.endDateLabel.AutoSize = true;
            this.endDateLabel.Location = new System.Drawing.Point(442, 101);
            this.endDateLabel.Name = "endDateLabel";
            this.endDateLabel.Size = new System.Drawing.Size(49, 13);
            this.endDateLabel.TabIndex = 13;
            this.endDateLabel.Text = "EndDate";
            // 
            // endTimeLabel
            // 
            this.endTimeLabel.AutoSize = true;
            this.endTimeLabel.Location = new System.Drawing.Point(563, 101);
            this.endTimeLabel.Name = "endTimeLabel";
            this.endTimeLabel.Size = new System.Drawing.Size(49, 13);
            this.endTimeLabel.TabIndex = 17;
            this.endTimeLabel.Text = "EndTime";
            // 
            // startTimeLabel
            // 
            this.startTimeLabel.AutoSize = true;
            this.startTimeLabel.Location = new System.Drawing.Point(563, 55);
            this.startTimeLabel.Name = "startTimeLabel";
            this.startTimeLabel.Size = new System.Drawing.Size(52, 13);
            this.startTimeLabel.TabIndex = 16;
            this.startTimeLabel.Text = "StartTime";
            // 
            // endTimePicker
            // 
            this.endTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.endTimePicker.Location = new System.Drawing.Point(566, 117);
            this.endTimePicker.Name = "endTimePicker";
            this.endTimePicker.ShowUpDown = true;
            this.endTimePicker.Size = new System.Drawing.Size(116, 20);
            this.endTimePicker.TabIndex = 15;
            // 
            // startTimePicker
            // 
            this.startTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.startTimePicker.Location = new System.Drawing.Point(566, 72);
            this.startTimePicker.Name = "startTimePicker";
            this.startTimePicker.ShowUpDown = true;
            this.startTimePicker.Size = new System.Drawing.Size(116, 20);
            this.startTimePicker.TabIndex = 14;
            // 
            // displayTextBox
            // 
            this.displayTextBox.Enabled = false;
            this.displayTextBox.Location = new System.Drawing.Point(717, 116);
            this.displayTextBox.Name = "displayTextBox";
            this.displayTextBox.Size = new System.Drawing.Size(100, 20);
            this.displayTextBox.TabIndex = 19;
            // 
            // setExportPathButton
            // 
            this.setExportPathButton.Location = new System.Drawing.Point(717, 143);
            this.setExportPathButton.Name = "setExportPathButton";
            this.setExportPathButton.Size = new System.Drawing.Size(100, 23);
            this.setExportPathButton.TabIndex = 20;
            this.setExportPathButton.Text = "Set Export Path";
            this.setExportPathButton.UseVisualStyleBackColor = true;
            this.setExportPathButton.Click += new System.EventHandler(this.SetExportPathButton_Click);
            // 
            // setExportPathTextBox
            // 
            this.setExportPathTextBox.Enabled = false;
            this.setExportPathTextBox.Location = new System.Drawing.Point(717, 173);
            this.setExportPathTextBox.Name = "setExportPathTextBox";
            this.setExportPathTextBox.Size = new System.Drawing.Size(100, 20);
            this.setExportPathTextBox.TabIndex = 21;
            // 
            // setExportPathSaveFileDialog
            // 
            this.setExportPathSaveFileDialog.DefaultExt = "csv";
            this.setExportPathSaveFileDialog.Filter = " \"csv files (*.csv)|*.csv|All files (*.*)|*.*\"";
            this.setExportPathSaveFileDialog.FileOk += new System.ComponentModel.CancelEventHandler(this.SetExportPathSaveFileDialog_FileOk);
            // 
            // selectEnvironmentComboBox
            // 
            this.selectEnvironmentComboBox.FormattingEnabled = true;
            this.selectEnvironmentComboBox.Location = new System.Drawing.Point(87, 13);
            this.selectEnvironmentComboBox.Name = "selectEnvironmentComboBox";
            this.selectEnvironmentComboBox.Size = new System.Drawing.Size(121, 21);
            this.selectEnvironmentComboBox.TabIndex = 23;
            this.selectEnvironmentComboBox.SelectedIndexChanged += new System.EventHandler(this.selectEnvironmentComboBox_SelectedIndexChanged);
            // 
            // dataTypeLabel
            // 
            this.dataTypeLabel.AutoSize = true;
            this.dataTypeLabel.Location = new System.Drawing.Point(241, 13);
            this.dataTypeLabel.Name = "dataTypeLabel";
            this.dataTypeLabel.Size = new System.Drawing.Size(54, 13);
            this.dataTypeLabel.TabIndex = 24;
            this.dataTypeLabel.Text = "DataType";
            // 
            // dataTypeComboBox
            // 
            this.dataTypeComboBox.FormattingEnabled = true;
            this.dataTypeComboBox.Location = new System.Drawing.Point(302, 13);
            this.dataTypeComboBox.Name = "dataTypeComboBox";
            this.dataTypeComboBox.Size = new System.Drawing.Size(121, 21);
            this.dataTypeComboBox.TabIndex = 25;
            this.dataTypeComboBox.SelectedIndexChanged += new System.EventHandler(this.dataTypeComboBox_SelectedIndexChanged);
            // 
            // environmentLabel
            // 
            this.environmentLabel.AutoSize = true;
            this.environmentLabel.Location = new System.Drawing.Point(15, 13);
            this.environmentLabel.Name = "environmentLabel";
            this.environmentLabel.Size = new System.Drawing.Size(66, 13);
            this.environmentLabel.TabIndex = 22;
            this.environmentLabel.Text = "Environment";
            // 
            // quoteSearchButton
            // 
            this.quoteSearchButton.Location = new System.Drawing.Point(717, 72);
            this.quoteSearchButton.Name = "quoteSearchButton";
            this.quoteSearchButton.Size = new System.Drawing.Size(100, 23);
            this.quoteSearchButton.TabIndex = 26;
            this.quoteSearchButton.Text = "Quote Search";
            this.quoteSearchButton.UseVisualStyleBackColor = true;
            this.quoteSearchButton.Click += new System.EventHandler(this.quoteSearchButton_Click);
            // 
            // statsRichTextBox
            // 
            this.statsRichTextBox.Location = new System.Drawing.Point(12, 161);
            this.statsRichTextBox.Name = "statsRichTextBox";
            this.statsRichTextBox.ReadOnly = true;
            this.statsRichTextBox.Size = new System.Drawing.Size(139, 217);
            this.statsRichTextBox.TabIndex = 29;
            this.statsRichTextBox.Text = "";
            this.statsRichTextBox.Visible = false;
            // 
            // showQueryStatsCheckBox
            // 
            this.showQueryStatsCheckBox.AutoSize = true;
            this.showQueryStatsCheckBox.Location = new System.Drawing.Point(12, 137);
            this.showQueryStatsCheckBox.Name = "showQueryStatsCheckBox";
            this.showQueryStatsCheckBox.Size = new System.Drawing.Size(111, 17);
            this.showQueryStatsCheckBox.TabIndex = 28;
            this.showQueryStatsCheckBox.Text = "Show Query Stats";
            this.showQueryStatsCheckBox.UseVisualStyleBackColor = true;
            this.showQueryStatsCheckBox.CheckedChanged += new System.EventHandler(this.showQueryStatsCheckBox_CheckedChanged);
            // 
            // QuoteSearchAndRetrievalOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(883, 672);
            this.Controls.Add(this.statsRichTextBox);
            this.Controls.Add(this.showQueryStatsCheckBox);
            this.Controls.Add(this.quoteSearchButton);
            this.Controls.Add(this.dataTypeComboBox);
            this.Controls.Add(this.dataTypeLabel);
            this.Controls.Add(this.selectEnvironmentComboBox);
            this.Controls.Add(this.environmentLabel);
            this.Controls.Add(this.setExportPathTextBox);
            this.Controls.Add(this.setExportPathButton);
            this.Controls.Add(this.displayTextBox);
            this.Controls.Add(this.endTimeLabel);
            this.Controls.Add(this.startTimeLabel);
            this.Controls.Add(this.endTimePicker);
            this.Controls.Add(this.startTimePicker);
            this.Controls.Add(this.endDateLabel);
            this.Controls.Add(this.startDateLabel);
            this.Controls.Add(this.endDatePicker);
            this.Controls.Add(this.startDatePicker);
            this.Controls.Add(this.symbolSearchButton);
            this.Controls.Add(this.symbolSearchLabel);
            this.Controls.Add(this.symbolSearchTextBox);
            this.Controls.Add(this.symbolListBox);
            this.Controls.Add(this.symbolLabel);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
            this.MaximizeBox = false;
            this.Name = "QuoteSearchAndRetrievalOptions";
            this.Text = "QuoteSearchAndRetrievalOptions";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.QuoteSearchAndRetrievalOptions_FormClosed);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label symbolLabel;
        protected System.Windows.Forms.ListBox symbolListBox;
        protected System.Windows.Forms.TextBox symbolSearchTextBox;
        private System.Windows.Forms.Label symbolSearchLabel;
        protected System.Windows.Forms.Button symbolSearchButton;
        protected System.Windows.Forms.DateTimePicker startDatePicker;
        protected System.Windows.Forms.DateTimePicker endDatePicker;
        private System.Windows.Forms.Label startDateLabel;
        private System.Windows.Forms.Label endDateLabel;
        private System.Windows.Forms.Label endTimeLabel;
        private System.Windows.Forms.Label startTimeLabel;
        protected System.Windows.Forms.DateTimePicker endTimePicker;
        protected System.Windows.Forms.DateTimePicker startTimePicker;
        protected System.Windows.Forms.TextBox displayTextBox;
        private Button setExportPathButton;
        protected TextBox setExportPathTextBox;
        protected SaveFileDialog setExportPathSaveFileDialog;
        protected ComboBox selectEnvironmentComboBox;
        private Label dataTypeLabel;
        protected ComboBox dataTypeComboBox;
        private Label environmentLabel;
        private Button quoteSearchButton;
        private RichTextBox statsRichTextBox;
        private CheckBox showQueryStatsCheckBox;
    }
}