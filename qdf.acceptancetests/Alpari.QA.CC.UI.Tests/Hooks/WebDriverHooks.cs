using System;
using System.Collections.Generic;
using Alpari.QA.CC.UI.Tests.BusinessProcesses;
using Alpari.QA.CC.UI.Tests.PageObjects;
using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Hooks
{
    [Binding]
    public class WebDriverHooks : SpecFlowExtensionsHooks
    {
        private static readonly string[] ExcludeColumns =
        {
            "Client Total", "Coverage Total", "Net Total", "∑ Net",
            "∑ Client", "∑ Cov", "CNX QAC", "QAH"
        };

        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            //TODO: configure to use parameters, read from config etc.
            if (TagDependentAction("IWebdriverCore"))
            {
                SetupWebdriverCore();
            }

            if (TagDependentAction("IPositionTablePageObject"))
            {
                SetupPositionTablePageObject();
            }
            if (TagDependentAction("ICcPositionTableComparisons"))
            {
                SetupCcPositionTableComparisons();
            }
            else if (TagDependentAction("ICcPositionTableComparison"))
            {
                SetupCcPositionTableComparison();
            }
        }

        private static List<ICcPositionTableComparison> SetupCcPositionTableComparisons()
        {
            List<ICcPositionTableComparison> list;
            try
            {
                list = ObjectContainer.Resolve<List<ICcPositionTableComparison>>();
            }
            catch (Exception)
            {
                list = new List<ICcPositionTableComparison>
                {
                    new CcPositionTableComparison(ExcludeColumns),
                    new CcPositionTableComparison(ExcludeColumns)
                };
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(list);
            }
            return list;
        }

        private static ICcPositionTableComparison SetupCcPositionTableComparison()
        {
            ICcPositionTableComparison ccPositionTableComparison;
            try
            {
                ccPositionTableComparison = ObjectContainer.Resolve<ICcPositionTableComparison>();
            }
            catch (Exception)
            {
                ccPositionTableComparison = new CcPositionTableComparison(ExcludeColumns);
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(ccPositionTableComparison);
            }

            return ccPositionTableComparison;
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
                iPageObject = SetupWebdriverCore().Create("4.6");
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
            if (TagDependentAction("IPositionTablePageObject") || TagDependentAction("IWebdriverCore"))
            {
                SetupWebdriverCore().Quit();
            }
            WebDriverCoreManager.RemoveAll();
        }
    }
}