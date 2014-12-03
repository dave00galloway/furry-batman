using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using BoDi;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Hooks
{
    [Binding]
    public class WebDriverHooks : SpecFlowExtensionsHooks
    {

        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            //TODO: configure to use parameters, read from config etc.
            SetupWebdriverCore();
        }

        private static WebdriverCore SetupWebdriverCore()
        {
            WebdriverCore wdc;
            try
            {
                wdc = ObjectContainer.Resolve<WebdriverCore>();
            }
            catch (Exception)
            {
                wdc = new WebdriverCore();
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(wdc);
            }
            return wdc;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}
