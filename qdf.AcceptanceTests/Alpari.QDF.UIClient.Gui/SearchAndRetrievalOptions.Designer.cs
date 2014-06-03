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
            this.BookListBox.SelectionMode = System.Windows.Forms.SelectionMode.One;
            this.BookListBox.Size = new System.Drawing.Size(120, 95);
            this.BookListBox.TabIndex = 3;
            // 
            // SearchAndRetrievalOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(883, 672);
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
    }
}