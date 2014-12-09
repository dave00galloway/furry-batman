using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QA.Webdriver.Core.Constants;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    public static class WebDriverFactory
    {
        public static IWebDriver Create(IReadOnlyDictionary<string, object> options)
        {
            IWebDriver webDriver;
            if (options == null)
            {
                webDriver = new ChromeDriver();
                return webDriver;
            }

            //todo:- at this point, check for an "Inherits" tag, search the manager for 

            switch (options[WebDriverConfig.Driver].ToString())
            {
                case WebDriverConfig.ChromeDriver:
                    webDriver = SetupChromeDriver(options);
                    break;

                default:
                    webDriver = new ChromeDriver();
                    break;
            }
            return webDriver;
        }

        private static ChromeDriver SetupChromeDriver(IReadOnlyDictionary<string, object> options)
        {
            ChromeDriver webDriver;
            //if we need to configure any settings using the chrome options, then set up the chrome options, otherwise don't bother
            //var co = new ChromeOptions();
            //co.
            webDriver = new ChromeDriver();
            webDriver.Manage()
                .Timeouts()
                .ImplicitlyWait(new TimeSpan(TimeSpan.TicksPerSecond * Convert.ToInt16(options[WebDriverConfig.ImplicitlyWait])));
            return webDriver;
        }
    }
}
