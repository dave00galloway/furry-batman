using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT4;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT5;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QA.CC.MT4Positions2RedisTests.Steps.StepCentral;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class ArsPositionsHooks : SpecFlowExtensionsHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
            SetupPositionsDataContext();
        }

        private void SetupPositionsDataContext()
        {
            if (TagDependentAction(StepCentral.MT4_ARS_POSTIONS_CONTEXT))
            {
                SetupPositionsContext();
            }
        }

        public static PositionsDataContext SetupPositionsContext()
        {
            var connectionString =
                ConfigurationManager.ConnectionStrings[StepCentral.ARS_CONNECTION_STRING].ConnectionString;
            var context = new PositionsDataContext(connectionString);
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(context);
            return context;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            ObjectContainer = null;
        }

        [BeforeFeature]
        public static void BeforeFeature()
        {
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }

    }
}
