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
            this.SuspendLayout();
            // 
            // ServerListBox
            // 
            this.ServerListBox.FormattingEnabled = true;
            this.ServerListBox.Location = new System.Drawing.Point(748, 40);
            this.ServerListBox.Name = "ServerListBox";
            this.ServerListBox.ScrollAlwaysVisible = true;
            this.ServerListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.ServerListBox.Size = new System.Drawing.Size(120, 95);
            this.ServerListBox.TabIndex = 0;
            // 
            // ServerLabel
            // 
            this.ServerLabel.AutoSize = true;
            this.ServerLabel.Location = new System.Drawing.Point(748, 21);
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
            this.SymbolLabel.Location = new System.Drawing.Point(169, 80);
            this.SymbolLabel.Name = "SymbolLabel";
            this.SymbolLabel.Size = new System.Drawing.Size(52, 13);
            this.SymbolLabel.TabIndex = 5;
            this.SymbolLabel.Text = "Symbol(s)";
            // 
            // SymbolListBox
            // 
            this.SymbolListBox.FormattingEnabled = true;
            this.SymbolListBox.Location = new System.Drawing.Point(172, 96);
            this.SymbolListBox.Name = "SymbolListBox";
            this.SymbolListBox.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.SymbolListBox.Size = new System.Drawing.Size(120, 95);
            this.SymbolListBox.TabIndex = 6;
            // 
            // SymbolSearchTextBox
            // 
            this.SymbolSearchTextBox.Location = new System.Drawing.Point(172, 40);
            this.SymbolSearchTextBox.Name = "SymbolSearchTextBox";
            this.SymbolSearchTextBox.Size = new System.Drawing.Size(120, 20);
            this.SymbolSearchTextBox.TabIndex = 7;
            this.SymbolSearchTextBox.TextChanged += new System.EventHandler(this.SymbolSearchTextBox_TextChanged);
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
            // SearchAndRetrievalOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(883, 672);
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
    }
}