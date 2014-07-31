using System;
using System.Configuration;
using System.Diagnostics.CodeAnalysis;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using BoDi;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    public class MasterStepBase
    {
        private static readonly string FullName = typeof(MasterStepBase).FullName;
        protected static readonly string StepBaseRootNameSpace = typeof(MasterStepBase).Namespace;
        public const string FEATURE_OUTPUT_DIRECTORY = "FeatureOutputDirectory";
        public const string SCENARIO_OUTPUT_DIRECTORY = "ScenarioOutputDirectory";
        public const string TEST_RUN_CONTEXT = "TestRunContext";
        public const string REPORT_ROOT = "reportRoot";
        protected static IObjectContainer ObjectContainer { get; set; }

        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors",
            Justification =
                "Unable to mark this class as abstract, so using an exceptional method to prevent direct inheritance")]
        protected MasterStepBase()
        {
// ReSharper disable once DoNotCallOverridableMethodsInConstructor
            ScenarioContext.Current[ToString()] = this;
            ThrowExceptionIfInMasterStepBase();
            TestRunContext = TestRunContext.Instance;
            ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof(IObjectContainer)) as IObjectContainer;
        }


        /// <summary>
        ///     This property gets set when the first Step Def using a class inheriting from MasterStepBase.
        ///     Access by Context.TestRunContext to access the static members, instead of having to add
        ///     using Alpari.QualityAssurance.SpecFlowExtensions.Context;
        ///     to the top of every step def file
        /// </summary>
        public TestRunContext TestRunContext { get; private set; }

        /// <summary>
        ///     gets a named step definiton file from the Scenario context.
        ///     Can't make this a property without setting up an indexer for each step definition class file, which wouldn't be any
        ///     more friendly than the Cucumber-JVM Step Central pattern
        /// </summary>
        /// <param name="stepDefinition">the name of the step definition to retrieve</param>
        /// <returns></returns>
        public static MasterStepBase GetStepDefinition(string stepDefinition)
        {
            if (!ScenarioContext.Current.ContainsKey(stepDefinition))
            {
                return null;
            }
            return (MasterStepBase) ScenarioContext.Current[stepDefinition];
        }


        /// <summary>
        /// Use this in a BeforeFeature to create and clear a unique output directory for Feature results in the ReportRoot as Specified in App.Config
        /// THe next level down will be the timestamp of the test run
        /// </summary>
        public static void SetupFeatureOutputDirectoryTimestampFirst()
        {
            FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY] = ConfigurationManager.AppSettings[REPORT_ROOT] +
                                                               TestRunContext.StaticFriendlyTime + @"\" +
                                                               FeatureContext.Current.FeatureInfo.Title.Replace(" ", "") +
                                                               @"\";
            ((string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY]).ClearOutputDirectory();
        }

        public static void SetupScenarioOutputDirectoryTimestampFirst()
        {
            ScenarioContext.Current[SCENARIO_OUTPUT_DIRECTORY] =
                (string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY] +
                ScenarioContext.Current.ScenarioInfo.Title.Replace(" ", "") + @"\";
            (ScenarioOutputDirectory).ClearOutputDirectory();
        }

        public static void InstantiateTestRunContext()
        {
            TestRunContext.Instance[TEST_RUN_CONTEXT] = TestRunContext.Instance;
        }

        /// <summary>
        /// TODO:- bypass ScenarioContext altogether?
        /// </summary>
        public static string ScenarioOutputDirectory
        {
            get { return (string)ScenarioContext.Current[SCENARIO_OUTPUT_DIRECTORY]; }
        }

        /// <summary>
        /// TODO:- bypass FeatureContext altogether?
        /// </summary>
        protected static string FeatureOutputDirectory
        {
            get { return (string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY]; }
        }

        /// <summary>
        ///     This class can't be marked as abstract, but it shouldn't be directly inherited from
        /// </summary>
        private void ThrowExceptionIfInMasterStepBase()
        {
            if (ToString().Equals(FullName))
            {
                throw new NotSupportedException("Don't inherit directly from this class, define your own StepCentral inheriting from MasterStepBase!"
                                                +
                                                "This class can't be marked as abstract, but it shouldn't be directly inherited from");
            }
        }
    }
}