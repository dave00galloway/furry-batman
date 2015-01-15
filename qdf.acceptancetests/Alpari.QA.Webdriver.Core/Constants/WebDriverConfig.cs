using System;
using System.Collections.Generic;

namespace Alpari.QA.Webdriver.Core.Constants
{
    /// <summary>
    ///     List of standard and custom option names for setting up webdriver instances
    /// </summary>
    public static class WebDriverConfig
    {
        #region drivers

        /// <summary>
        ///     the type of driver to set up (Chrome, IE, FF etc)
        /// </summary>
        public const string Driver = "Driver";

        public const string ChromeDriver = "ChromeDriver";

        #endregion

        #region Timeouts

        public const string ImplicitlyWait = "ImplicitlyWait";

        #endregion

        #region custom - test

        public const string BaseUrl = "BaseUrl";

        #endregion

        #region custom - config

        public const string WebDriverCoreConfig = "IWebDriverCoreConfig";
        public const string WebDriverCoreConfigPath = @"DriverConfig\";
        public const string WebDriverCoreConfigFormat = ".xml";
        public const string InheritsFrom = "InheritsFrom";
        public const string Name = "Name";

        #endregion

        public static TimeSpan GetImplicitWait(this IReadOnlyDictionary<string, string> options)
        {
            const string wait = "40"; //todo:- create some hardcoded defaults, or make _options a proper class
            return options != null ? options.TimeToWait(ImplicitlyWait) : wait.TimeToTimeSpan();
        }

        /// <summary>
        /// TODO:- add polling freq to options xml
        /// </summary>
        /// <param name="options"></param>
        /// <returns></returns>
        public static TimeSpan GetPollingFrequency(this IReadOnlyDictionary<string, string> options)
        {
            const int interval = 50; //todo:- create some hardcoded defaults, or make _options a proper class
            return new TimeSpan(0,0,0,0,interval);
        }
    }
}