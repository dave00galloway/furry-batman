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
    public partial class SearchAndRetrievalOptions : Form
    {
        protected Exporter Exporter { get; set; }
        protected ControlSetup ControlSetup { get; set; }

        public SearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup)
        {
            InitializeComponent();
            Exporter = exporter;
            ControlSetup = controlSetup;
            SetupBookListBox();
            SetupSymbolListBox();
            SetupServerListBox();
        }

        private void SetupBookListBox()
        {
            foreach (var book in ControlSetup.BookControl.BookList)
            {
                BookListBox.Items.Add(book);
            }
        }

        private void SetupSymbolListBox()
        {
            foreach (var symbol in ControlSetup.SymbolControl.SymbolListItems)
            {
                SymbolListBox.Items.Add(symbol.Symbol);
            }
        }

        private void SetupServerListBox()
        {
            foreach (string server in ControlSetup.TradingServerControl.ServerList)
            {
                ServerListBox.Items.Add(server);
            }
        }

        private void SymbolSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            var pos = SymbolSearchTextBox.SelectionStart;
            var typed = SymbolSearchTextBox.Text.Substring(0, pos);
            if (SearchSymbolList(typed))
            {
                SymbolListBox.TopIndex = GetItemIndex(typed);
            }
        }

        private int GetItemIndex(string typed)
        {
            for (int i = 0; i < SymbolListBox.Items.Count; i++)
            {
                if (SymbolListBox.Items[i].ToString().Substring(0, typed.Length).Equals(typed,StringComparison.InvariantCulture))
                {
                    return i;
                }
            }
            return 0;
        }

        private bool SearchSymbolList(string typed)
        {
            bool found = false;
            foreach (var item in SymbolListBox.Items)
            {
                if (item.ToString().Contains(typed))
                {
                    found = true;
                }
            }
            return found;
        }
    }
}
