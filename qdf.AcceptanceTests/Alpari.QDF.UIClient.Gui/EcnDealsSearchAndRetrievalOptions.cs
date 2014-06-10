using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;

namespace Alpari.QDF.UIClient.Gui
{
    public partial class EcnDealsSearchAndRetrievalOptions : SearchAndRetrievalOptions
    {
        public EcnDealsSearchAndRetrievalOptions(Exporter exporter, ControlSetup controlSetup) : base(exporter, controlSetup)
        {
            InitializeComponent();
        }
    }
}
