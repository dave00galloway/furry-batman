using System;
using System.Collections.Generic;
using Alpari.QA.Webdriver.Core.Constants;
using log4net;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    public static class WebDriverFactory
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof (WebDriverFactory));

        public static IWebDriver Create(IReadOnlyDictionary<string, string> options)
        {
//            BasicConfigurator.Configure();
            Log.Debug("loading webdriver");
            IWebDriver webDriver;
            if (options == null)
            {
                webDriver = DefaultWebDriver();
                return webDriver;
            }

            //           BasicConfigurator.Configure();

            //todo:- at this point, check for an "Inherits" tag, search the manager for 
            Log.DebugFormat("loading webdriver {0}", options[WebDriverConfig.Driver]);
            switch (options[WebDriverConfig.Driver])
            {
                case WebDriverConfig.ChromeDriver:
                    webDriver = SetupChromeDriver(options);
                    break;

                default:
                    webDriver = DefaultWebDriver();
                    break;
            }
            return webDriver;
        }

        private static IWebDriver DefaultWebDriver()
        {
            Log.Debug("loading webdriver using default configuration");
            IWebDriver webDriver = new ChromeDriver();
            return webDriver;
        }

        private static ChromeDriver SetupChromeDriver(IReadOnlyDictionary<string, string> options)
        {
            ChromeDriver webDriver;
            //if we need to configure any settings using the chrome options, then set up the chrome options, otherwise don't bother
            //var co = new ChromeOptions();
            //co.
            webDriver = new ChromeDriver();
            webDriver.SetTimeout(options, WebDriverConfig.ImplicitlyWait);
            return webDriver;
        }
    }
}
