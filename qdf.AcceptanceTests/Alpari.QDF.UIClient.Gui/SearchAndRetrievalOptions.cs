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

        private void SymbolSearchButton_Click(object sender, EventArgs e)
        {
            var pos = SymbolSearchTextBox.SelectionStart;
            var typed = SymbolSearchTextBox.Text.Substring(0, pos);
            SearchAndScrollList(SymbolListBox, typed);
        }

        private static void SearchAndScrollList(ListBox listBox, string typed)
        {
            if (SearchListBox(listBox,typed))
            {
                var index = GetItemIndex(listBox, typed);
                listBox.TopIndex = index;
                if (index >= 0)
                {
                    listBox.SetSelected(index, true);
                }
            }
        }

        private static int GetItemIndex(ListBox listBox, string typed)
        {
            for (int i = 0; i < listBox.Items.Count; i++)
            {
                if (listBox.Items[i].ToString().Substring(0, typed.Length).Equals(typed,StringComparison.InvariantCulture))
                {
                    return i;
                }
            }
            return -1;
        }

        private static bool SearchListBox(ListBox listBox, string typed)
        {
            bool found = false;
            foreach (var item in listBox.Items)
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
