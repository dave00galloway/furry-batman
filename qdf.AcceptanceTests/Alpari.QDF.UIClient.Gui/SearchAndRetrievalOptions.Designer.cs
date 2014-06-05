using System.Windows.Forms;

namespace Alpari.QDF.UIClient.Gui
{
    partial class SearchAndRetrievalOptions
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
            this.ServerListBox = new System.Windows.Forms.ListBox();
            this.ServerLabel = new System.Windows.Forms.Label();
            this.BookLabel = new System.Windows.Forms.Label();
            this.BookListBox = new System.Windows.Forms.ListBox();
            this.SymbolLabel = new System.Windows.Forms.Label();
            this.SymbolListBox = new System.Windows.Forms.ListBox();
            this.SymbolSearchTextBox = new System.Windows.Forms.TextBox();
            this.SymbolSearchLabel = new System.Windows.Forms.Label();
            this.SymbolSearchButton = new System.Windows.Forms.Button();
            this.StartDatePicker = new System.Windows.Forms.DateTimePicker();
            this.EndDatePicker = new System.Windows.Forms.DateTimePicker();
            this.StartDateLabel = new System.Windows.Forms.Label();
            this.EndDateLabel = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.StartTime = new System.Windows.Forms.Label();
            this.EndTimePicker = new System.Windows.Forms.DateTimePicker();
            this.StartTimePicker = new System.Windows.Forms.DateTimePicker();
            this.FindDealsButton = new System.Windows.Forms.Button();
            this.Display = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // ServerListBox
            // 
            this.ServerListBox.FormattingEnabled = true;
            this.ServerListBox.Location = new System.Drawing.Point(317, 40);
            this.ServerListBox.Name = "ServerListBox";
            this.ServerListBox.ScrollAlwaysVisible = true;
            this.ServerListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.ServerListBox.Size = new System.Drawing.Size(120, 95);
            this.ServerListBox.TabIndex = 0;
            // 
            // ServerLabel
            // 
            this.ServerLabel.AutoSize = true;
            this.ServerLabel.Location = new System.Drawing.Point(317, 21);
            this.ServerLabel.Name = "ServerLabel";
            this.ServerLabel.Size = new System.Drawing.Size(38, 13);
            this.ServerLabel.TabIndex = 1;
            this.ServerLabel.Text = "Server";
            // 
            // BookLabel
            // 
            this.BookLabel.AutoSize = true;
            this.BookLabel.Location = new System.Drawing.Point(13, 21);
            this.BookLabel.Name = "BookLabel";
            this.BookLabel.Size = new System.Drawing.Size(32, 13);
            this.BookLabel.TabIndex = 2;
            this.BookLabel.Text = "Book";
            // 
            // BookListBox
            // 
            this.BookListBox.FormattingEnabled = true;
            this.BookListBox.Location = new System.Drawing.Point(16, 40);
            this.BookListBox.Name = "BookListBox";
            this.BookListBox.Size = new System.Drawing.Size(120, 95);
            this.BookListBox.TabIndex = 3;
            // 
            // SymbolLabel
            // 
            this.SymbolLabel.AutoSize = true;
            this.SymbolLabel.Location = new System.Drawing.Point(169, 106);
            this.SymbolLabel.Name = "SymbolLabel";
            this.SymbolLabel.Size = new System.Drawing.Size(52, 13);
            this.SymbolLabel.TabIndex = 5;
            this.SymbolLabel.Text = "Symbol(s)";
            // 
            // SymbolListBox
            // 
            this.SymbolListBox.FormattingEnabled = true;
            this.SymbolListBox.Location = new System.Drawing.Point(172, 122);
            this.SymbolListBox.Name = "SymbolListBox";
            this.SymbolListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.SymbolListBox.Size = new System.Drawing.Size(120, 394);
            this.SymbolListBox.TabIndex = 6;
            // 
            // SymbolSearchTextBox
            // 
            this.SymbolSearchTextBox.Location = new System.Drawing.Point(172, 40);
            this.SymbolSearchTextBox.Name = "SymbolSearchTextBox";
            this.SymbolSearchTextBox.Size = new System.Drawing.Size(120, 20);
            this.SymbolSearchTextBox.TabIndex = 7;
            // 
            // SymbolSearchLabel
            // 
            this.SymbolSearchLabel.AutoSize = true;
            this.SymbolSearchLabel.Location = new System.Drawing.Point(172, 20);
            this.SymbolSearchLabel.Name = "SymbolSearchLabel";
            this.SymbolSearchLabel.Size = new System.Drawing.Size(75, 13);
            this.SymbolSearchLabel.TabIndex = 8;
            this.SymbolSearchLabel.Text = "SymbolSearch";
            // 
            // SymbolSearchButton
            // 
            this.SymbolSearchButton.Location = new System.Drawing.Point(172, 66);
            this.SymbolSearchButton.Name = "SymbolSearchButton";
            this.SymbolSearchButton.Size = new System.Drawing.Size(120, 23);
            this.SymbolSearchButton.TabIndex = 9;
            this.SymbolSearchButton.Text = "Search Symbols";
            this.SymbolSearchButton.UseVisualStyleBackColor = true;
            this.SymbolSearchButton.Click += new System.EventHandler(this.SymbolSearchButton_Click);
            // 
            // StartDatePicker
            // 
            this.StartDatePicker.Location = new System.Drawing.Point(446, 37);
            this.StartDatePicker.Name = "StartDatePicker";
            this.StartDatePicker.Size = new System.Drawing.Size(116, 20);
            this.StartDatePicker.TabIndex = 10;
            // 
            // EndDatePicker
            // 
            this.EndDatePicker.Location = new System.Drawing.Point(446, 82);
            this.EndDatePicker.Name = "EndDatePicker";
            this.EndDatePicker.Size = new System.Drawing.Size(116, 20);
            this.EndDatePicker.TabIndex = 11;
            // 
            // StartDateLabel
            // 
            this.StartDateLabel.AutoSize = true;
            this.StartDateLabel.Location = new System.Drawing.Point(443, 20);
            this.StartDateLabel.Name = "StartDateLabel";
            this.StartDateLabel.Size = new System.Drawing.Size(52, 13);
            this.StartDateLabel.TabIndex = 12;
            this.StartDateLabel.Text = "StartDate";
            // 
            // EndDateLabel
            // 
            this.EndDateLabel.AutoSize = true;
            this.EndDateLabel.Location = new System.Drawing.Point(443, 66);
            this.EndDateLabel.Name = "EndDateLabel";
            this.EndDateLabel.Size = new System.Drawing.Size(49, 13);
            this.EndDateLabel.TabIndex = 13;
            this.EndDateLabel.Text = "EndDate";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(564, 66);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(49, 13);
            this.label1.TabIndex = 17;
            this.label1.Text = "EndTime";
            // 
            // StartTime
            // 
            this.StartTime.AutoSize = true;
            this.StartTime.Location = new System.Drawing.Point(564, 20);
            this.StartTime.Name = "StartTime";
            this.StartTime.Size = new System.Drawing.Size(52, 13);
            this.StartTime.TabIndex = 16;
            this.StartTime.Text = "StartTime";
            // 
            // EndTimePicker
            // 
            this.EndTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.EndTimePicker.Location = new System.Drawing.Point(567, 82);
            this.EndTimePicker.Name = "EndTimePicker";
            this.EndTimePicker.ShowUpDown = true;
            this.EndTimePicker.Size = new System.Drawing.Size(116, 20);
            this.EndTimePicker.TabIndex = 15;
            // 
            // StartTimePicker
            // 
            this.StartTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.StartTimePicker.Location = new System.Drawing.Point(567, 37);
            this.StartTimePicker.Name = "StartTimePicker";
            this.StartTimePicker.ShowUpDown = true;
            this.StartTimePicker.Size = new System.Drawing.Size(116, 20);
            this.StartTimePicker.TabIndex = 14;
            // 
            // FindDealsButton
            // 
            this.FindDealsButton.Location = new System.Drawing.Point(718, 40);
            this.FindDealsButton.Name = "FindDealsButton";
            this.FindDealsButton.Size = new System.Drawing.Size(75, 23);
            this.FindDealsButton.TabIndex = 18;
            this.FindDealsButton.Text = "FindDeals";
            this.FindDealsButton.UseVisualStyleBackColor = true;
            this.FindDealsButton.Click += new System.EventHandler(this.FindDeals_Click);
            // 
            // Display
            // 
            this.Display.Enabled = false;
            this.Display.Location = new System.Drawing.Point(718, 81);
            this.Display.Name = "Display";
            this.Display.Size = new System.Drawing.Size(100, 20);
            this.Display.TabIndex = 19;
            // 
            // SearchAndRetrievalOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(883, 672);
            this.Controls.Add(this.Display);
            this.Controls.Add(this.FindDealsButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.StartTime);
            this.Controls.Add(this.EndTimePicker);
            this.Controls.Add(this.StartTimePicker);
            this.Controls.Add(this.EndDateLabel);
            this.Controls.Add(this.StartDateLabel);
            this.Controls.Add(this.EndDatePicker);
            this.Controls.Add(this.StartDatePicker);
            this.Controls.Add(this.SymbolSearchButton);
            this.Controls.Add(this.SymbolSearchLabel);
            this.Controls.Add(this.SymbolSearchTextBox);
            this.Controls.Add(this.SymbolListBox);
            this.Controls.Add(this.SymbolLabel);
            this.Controls.Add(this.BookListBox);
            this.Controls.Add(this.BookLabel);
            this.Controls.Add(this.ServerLabel);
            this.Controls.Add(this.ServerListBox);
            this.Name = "SearchAndRetrievalOptions";
            this.Text = "SearchAndRetrievalOptions";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox ServerListBox;
        private System.Windows.Forms.Label ServerLabel;
        private System.Windows.Forms.Label BookLabel;
        private System.Windows.Forms.ListBox BookListBox;
        private System.Windows.Forms.Label SymbolLabel;
        private System.Windows.Forms.ListBox SymbolListBox;
        private System.Windows.Forms.TextBox SymbolSearchTextBox;
        private System.Windows.Forms.Label SymbolSearchLabel;
        private System.Windows.Forms.Button SymbolSearchButton;
        private System.Windows.Forms.DateTimePicker StartDatePicker;
        private System.Windows.Forms.DateTimePicker EndDatePicker;
        private System.Windows.Forms.Label StartDateLabel;
        private System.Windows.Forms.Label EndDateLabel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label StartTime;
        private System.Windows.Forms.DateTimePicker EndTimePicker;
        private System.Windows.Forms.DateTimePicker StartTimePicker;
        private System.Windows.Forms.Button FindDealsButton;
        private System.Windows.Forms.TextBox Display;
    }
}