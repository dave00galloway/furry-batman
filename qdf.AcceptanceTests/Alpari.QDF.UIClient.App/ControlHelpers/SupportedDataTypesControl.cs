﻿using System.Collections.Generic;
using System.Configuration;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class SupportedDataTypesControl 
    {
        public const string CURRENT_STATE = "CurrentState";
        public const string DEAL = "Deal";
        public const string PRICE_QUOTE = "PriceQuote";
        public const string ECN_DEAL = "ecn-Deal";

        private string _default;
        

        public SupportedDataTypesControl()
        {
            Types = new List<string>
            {
                CURRENT_STATE,
                DEAL,
                PRICE_QUOTE,
                ECN_DEAL
            };
        }

        /// <summary>
        /// For consistency, these could come from ref data, although it's not a strictly agreed list yet so this will do for now
        /// </summary>
        public List<string> Types { get; private set; }

        public string Default
        {
            get
            {
                if (_default != null) return _default;
                var config = App.GetConfiguration(GetType());
                var section = (AppSettingsSection)config.GetSection(App.CONTROL_SECTION_NAME);
                _default = section.Settings[App.DEFAULT_DATATYPE].Value;
                return _default;
            }
        }
    }
}
