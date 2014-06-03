using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QDF.UIClient.App
{
    public static class App
    {
        public const string LIST_SEPERATOR = "listSeperator";
        public const string BEHAVIOUR_SECTION_NAME = "Behaviour";
        public const string CONTROL_SECTION_NAME = "Controls";
        public const string SYMBOL_LIST_NAME = "symbolList";

        public static char GetSeperatorValue(Configuration config)
        {
            var section = (AppSettingsSection)config.GetSection(App.BEHAVIOUR_SECTION_NAME);
            return Convert.ToChar(section.Settings[App.LIST_SEPERATOR].Value);
        }
    }
}
