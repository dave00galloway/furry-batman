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
        }

        private void QuoteSearchAndRetrievalOptions_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }
    }
}
