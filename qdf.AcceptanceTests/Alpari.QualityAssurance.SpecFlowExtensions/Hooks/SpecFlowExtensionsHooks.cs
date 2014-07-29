using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using BoDi;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Hooks
{
    [Binding]
    public class SpecFlowExtensionsHooks
    {
        protected static string[] FeatureTags;
        protected static string[] ScenarioTags;
        protected static IObjectContainer ObjectContainer { get; set; }

        protected void SetupObjectContainerAndTagsProperties()
        {
            ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof(IObjectContainer)) as IObjectContainer;
            FeatureTags = FeatureContext.Current.FeatureInfo.Tags;
            ScenarioTags = ScenarioContext.Current.ScenarioInfo.Tags;
        }

        /// <summary>
        /// return true or fals to perform a setup/teardown action if either feature or scenario tags contain a specified value
        /// </summary>
        /// <param name="searchString"></param>
        /// <returns></returns>
        protected bool TagDependentAction(string searchString)
        {
            if (FeatureTags.Contains(searchString) || ScenarioTags.Contains(searchString))
            {
                return true;
            }
            return false;
        }
    }
}
