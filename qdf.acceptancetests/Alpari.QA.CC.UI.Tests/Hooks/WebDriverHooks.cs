using System;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.CC.UI.Tests.Steps;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
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

            SetupPositionTablePageObject();
        }

        private static IPositionTablePageObject SetupPositionTablePageObject()
        {
            IPositionTablePageObject iPageObject;
            try
            {
                iPageObject = ObjectContainer.Resolve<IPositionTablePageObject>();
            }
            catch (Exception)
            {
                iPageObject = new PositionTablePageObject(SetupWebdriverCore());
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(iPageObject);
            }
            return iPageObject;
        }

        private static IWebdriverCore SetupWebdriverCore()
        {
            IWebdriverCore wdc;
            try
            {
                wdc = ObjectContainer.Resolve<IWebdriverCore>();
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
            //TODO: if we decided to use Core as a container, then nothing needs to change here. if we use a container for cores, then we need to iterate over them and close all sel instances
            StepCentral.WebdriverCore.Quit();
            WebDriverCoreManager.RemoveAll();
        }
    }
}