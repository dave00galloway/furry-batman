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

namespace Alpari.QDF.UIClient.Gui
{
    public partial class SearchAndRetrievalOptions : Form
    {
        public SearchAndRetrievalOptions(RedisConnectionHelper redisConnectionHelper)
        {
            InitializeComponent();
        }
    }
}
