using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class SymbolControl
    {
        private readonly char _separator;

        public List<SymbolListItem> SymbolListItems { get; private set ; }
        public SymbolControl()
        {
            var config = GetConfiguration();
            _separator = App.GetSeperatorValue(config);
            var symbolPath = GetSymbolPath(config);
            SymbolListItems = symbolPath.CsvToList<SymbolListItem>(_separator.ToString(CultureInfo.InvariantCulture));
        }

        private string GetSymbolPath(Configuration config)
        {
            var section = (AppSettingsSection)config.GetSection(App.CONTROL_SECTION_NAME);
            return section.Settings[App.SYMBOL_LIST_NAME].Value;
        }

        private Configuration GetConfiguration()
        {
            Configuration config =
                ConfigurationManager.OpenExeConfiguration(String.Format("{0}.dll",
                    GetType().Assembly.GetName().Name.ToString(CultureInfo.InvariantCulture)));
            return config;
        }
    }
}
