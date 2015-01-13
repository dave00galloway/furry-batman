using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QA.Webdriver.Core.Constants;
using OpenQA.Selenium;

namespace Alpari.QA.Webdriver.Core
{
    public static class TimeoutExtensions
    {
        public static void SetTimeout(this IWebDriver driver, IReadOnlyDictionary<string, string> options,
            string timeoutName)
        {
            switch (timeoutName)
            {
                case WebDriverConfig.ImplicitlyWait:
                    driver.Manage()
                        .Timeouts()
                        .ImplicitlyWait(options.TimeToWait(timeoutName));
                    break;
                default:
                    driver.Manage()
                        .Timeouts()
                        .ImplicitlyWait(options.TimeToWait(timeoutName));
                    break;
            }
        }

        /// <summary>
        /// Get a Timespan from the WebDriverCore options from the name of a timeout assumed to be a timeout in seconds as string
        /// </summary>
        /// <param name="options"></param>
        /// <param name="timeoutName"></param>
        /// <returns></returns>
        public static TimeSpan TimeToWait(this IReadOnlyDictionary<string, string> options, string timeoutName)
        {
            var timeout = options[timeoutName];
            return timeout.TimeToTimeSpan();
        }

        /// <summary>
        /// Convert seconds as string to a TimeSpan
        /// </summary>
        /// <param name="timeout"></param>
        /// <returns></returns>
        public static TimeSpan TimeToTimeSpan(this string timeout)
        {
            return new TimeSpan(TimeSpan.TicksPerSecond*Convert.ToInt16(timeout));
        }
    }
}
