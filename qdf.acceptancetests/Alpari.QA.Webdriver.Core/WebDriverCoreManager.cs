using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace Alpari.QA.Webdriver.Core
{
    public class WebDriverCoreManager
    {
        private static volatile WebDriverCoreManager _instance;
        private static readonly object InstanceRoot = new Object();
        //private static readonly object AddRoot = new Object(); // trusting that since we aren't accessing fields (except Drivers which is inherently threadsafe) we don't need to lock any opther bits of code

        private static readonly IDictionary<string, IWebdriverCore> Drivers =
            new ConcurrentDictionary<string, IWebdriverCore>();

        private WebDriverCoreManager()
        {
        }

        public static WebDriverCoreManager Instance
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
        ///     return it
        /// </summary>
        /// <param name="webdriverConfigFile"></param>
        /// <returns></returns>
        public static IWebdriverCore Add(string webdriverConfigFile)
        {
            IWebdriverCore wdc =
                new WebdriverCore(
                    new ReadOnlyDictionary<string, object>(
                        webdriverConfigFile.ParseXmlAsDictionary("IWebDriverCoreConfig")));
            return wdc;
        }
    }
}