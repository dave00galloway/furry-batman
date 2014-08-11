using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Hooks
{
    [Binding, Scope(Tag = "UKUSQDF_170")]
    public class Ukusqdf170PreserveTestEvidenceBetweenExamplesHooks : SpecFlowExtensionsHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            
            SetupObjectContainerAndTagsProperties();

            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();

        }

        [AfterScenario]
        public void AfterScenario()
        {

        }

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeFeature("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeFeature]
        public static void BeforeFeature()
        {
            MasterStepBase.InstantiateTestRunContext();
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
        }

        //[BeforeTestRun]
        //public static void BeforeTestRun()
        //{
        //    MasterStepBase.InstantiateTestRunContext();
        //}
    }
}
