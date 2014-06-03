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
            SetupServerListBox();
        }

        private void SetupBookListBox()
        {
            foreach (var book in ControlSetup.BookControl.BookList)
            {
                BookListBox.Items.Add(book);
            }
        }

        private void SetupServerListBox()
        {
            foreach (string server in ControlSetup.TradingServerControl.ServerList)
            {
                ServerListBox.Items.Add(server);
            }
        }
    }
}
