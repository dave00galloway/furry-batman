using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using BoDi;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Hooks
{
    [Binding]
    public class SpecFlowExtensionsHooks
    {
        public const string EXAMPLE_IDENTIFIER = "ExampleIdentifier";
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

        /// <summary>
        /// shift the current output directory to a new output directory as a sibling to the current output directory
        /// and delete the original output directory if successful
        /// </summary>
        protected static void MoveExampleEvidence()
        {
            if (ScenarioContext.Current.ContainsKey(EXAMPLE_IDENTIFIER))
            {
                string newDirectory = String.Format("{0}{1}{2}", MasterStepBase.ScenarioOutputDirectory.TrimEnd(new[] { '\\' }),
                    ScenarioContext.Current[EXAMPLE_IDENTIFIER].RemoveWindowsUnfriendlyChars(), @"\");
                MasterStepBase.ScenarioOutputDirectory.RecursivelyCopyDirectory(newDirectory,true);
            }
        }
    }
}
