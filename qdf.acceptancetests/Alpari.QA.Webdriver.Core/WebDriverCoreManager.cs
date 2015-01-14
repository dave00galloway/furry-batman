using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using Alpari.QA.Webdriver.Core.Constants;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QA.Webdriver.Core
{
    public sealed class WebDriverCoreManager
    {
        private static volatile WebDriverCoreManager _instance;
        private static readonly object InstanceRoot = new Object();
        //private static readonly object AddRoot = new Object(); // trusting that since we aren't accessing fields (except Drivers which is inherently threadsafe) we don't need to lock any opther bits of code

        private readonly IDictionary<string, IWebdriverCore> _drivers =
            new ConcurrentDictionary<string, IWebdriverCore>();

        private WebDriverCoreManager()
        {
        }

        private static WebDriverCoreManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (InstanceRoot)
                    {
                        if (_instance == null)
                            _instance = new WebDriverCoreManager();
                    }
                }
                return _instance;
            }
        }

        /// <summary>
        ///     Create a new webdriver, configure it with options specified in the file, add it to the Drivers collection, and
        ///     return it.
        ///     Will throw an exception if an attempt is made to add a driver with an existing name
        /// </summary>
        /// <param name="webdriverConfigFile"></param>
        /// <returns></returns>
        public static IWebdriverCore Add(string webdriverConfigFile)
        {
            return AddWebdriverCore(webdriverConfigFile, webdriverConfigFile);
        }

        public static IWebdriverCore Add(string name, string webdriverConfigFile)
        {
            return AddWebdriverCore(name, webdriverConfigFile);
        }

        private static IWebdriverCore AddWebdriverCore(string name, string webdriverConfigFile)
        {
            var fileNamePath = WebDriverConfig.WebDriverCoreConfigPath + webdriverConfigFile +
                               WebDriverConfig.WebDriverCoreConfigFormat;
            var wdc = Create(fileNamePath); //new WebdriverCore(MergeOptionsWithParent(fileNamePath));
            Instance._drivers.Add(name, wdc);
            return wdc;
        }

        /// <summary>
        ///     Factory Method for WebDriverCore
        /// </summary>
        /// <param name="fileNamePath"></param>
        /// <returns></returns>
        public static IWebdriverCore Create(string fileNamePath)
        {
            var options = MergeOptionsWithParent(fileNamePath);
            return new WebdriverCore(options, new ElementFinder());
        }

        private static IReadOnlyDictionary<string, string> MergeOptionsWithParent(string fileNamePath)
        {
            IDictionary<string, string> dict = fileNamePath.ParseXmlAsDictionary(WebDriverConfig.WebDriverCoreConfig);
            if (dict.ContainsKey(WebDriverConfig.InheritsFrom))
            {
                var parentDriverName = dict[WebDriverConfig.InheritsFrom];
                if (Drivers(parentDriverName) == null)
                {
                    lock (InstanceRoot)
                    {
                        if (Drivers(parentDriverName) == null)
                        {
                            Add(parentDriverName);
                        }
                    }
                }
                foreach (var option in Drivers(parentDriverName)
                    .Options.Where(option => !dict.ContainsKey(option.Key)))
                {
                    dict[option.Key] = option.Value;
                }
            }
            return new ReadOnlyDictionary<string, string>(dict);
        }

        public static IWebdriverCore Drivers(string key)
        {
            try
            {
                return Instance._drivers[key];
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static IEnumerable<IWebdriverCore> Drivers(string key, string value)
        {
            return Instance._drivers.Where(d => d.Value.Options[key] == value).Select(d => d.Value);
        }

        public static void RemoveAll()
        {
            //will potentially create a manager instnace just to close 0 drivers, but this is the safest option and creating the manager is cheap
            foreach (var driver in Instance._drivers)
            {
                driver.Value.Quit();
                Instance._drivers.Remove(driver.Key);
            }
        }
    }
}