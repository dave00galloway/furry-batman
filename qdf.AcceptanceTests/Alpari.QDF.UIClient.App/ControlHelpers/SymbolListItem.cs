using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class SymbolListItem
    {
        public string Symbol { get; [UsedImplicitly] set; }
    }
}
