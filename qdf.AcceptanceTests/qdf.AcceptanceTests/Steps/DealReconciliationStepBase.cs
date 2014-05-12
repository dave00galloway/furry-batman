using System;
using System.Collections.Generic;
using System.Configuration;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationStepBase :StepCentral
    {
        public static readonly string FullName = typeof (DealReconciliationStepBase).FullName;

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeFeature("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeFeature]
        public static void BeforeFeature()
        {
            FeatureContext.Current["FeatureOutputDirectory"] = ConfigurationManager.AppSettings["reportRoot"] +
                                                               TestRunContext.StaticFriendlyTime + @"\" +
                                                               FeatureContext.Current.FeatureInfo.Title.Replace(" ", "") +
                                                               @"\";
            ((string)FeatureContext.Current["FeatureOutputDirectory"]).ClearOutputDirectory();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            TestRunContext.Instance["TestRunContext"] = TestRunContext.Instance;
        }

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeScenario("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeScenario]
        public static void BeforeScenario()
        {
            ScenarioContext.Current["ScenarioOutputDirectory"] =
                (string)FeatureContext.Current["FeatureOutputDirectory"] +
                ScenarioContext.Current.ScenarioInfo.Title.Replace(" ", "") + @"\";
            (ScenarioOutputDirectory).ClearOutputDirectory();
        }

        /// <summary>
        /// TODO:- move to MasterStepBase, add setter and bypass ScenarioContext altogether?
        /// </summary>
        protected static string ScenarioOutputDirectory
        {
            get { return (string)ScenarioContext.Current["ScenarioOutputDirectory"]; }
        }

        /// <summary>
        /// TODO:- move to MasterStepBase, add setter and bypass FeatureContext altogether?
        /// </summary>
        protected static string FeatureOutputDirectory
        {
            get { return (string)FeatureContext.Current["FeatureOutputDirectory"]; }
        }

        public static void SetupQdfDealQuery(QdfDealParameters entry)
        {
            string start = entry.StartTime ?? ConfigurationManager.AppSettings["defaultStartTime"];
            string end = entry.EndTime ?? ConfigurationManager.AppSettings["defaultEndTime"];
            entry.ConvertedStartTime = start.GetTimeFromShortCode();
            entry.ConvertedEndTime = end.GetTimeFromShortCode(entry.ConvertedStartTime);
        }

        [StepArgumentTransformation(@"Deal Data for these parameter sets:")]
        public static IEnumerable<QdfDealParameters> QdfDealParametersTransformSet(Table table)
        {
            return table.CreateSet<QdfDealParameters>();
        }

        [StepArgumentTransformation]
        public static QdfDealParameters QdfDealParametersTransform(Table table)
        {
            return table.CreateInstance<QdfDealParameters>();
        }

        public static IDataContextSubstitute GetDataContextSubstitute(string dataContext)
        {
            switch (dataContext)
            {
                case "MySqlDataContextSubstitute":
                    return
                        new CcToolDataContext(
                            ConfigurationManager.ConnectionStrings[
                                ConfigurationManager.AppSettings["defaultConnectionString"]].ConnectionString.UnProtect(
                                    '_'));
                case "QuickStartMySqlDataContext":
                    //QuickStartMySqlDataContext context = new QuickStartMySqlDataContext();
                    throw new ArgumentException("data context {0} is licensed and there is no license available",
                        dataContext);
                default:
                    throw new ArgumentException("data context {0} is not a valid data context", dataContext);
            }
        }

        public static IDataContextSubstitute GetDataContextSubstituteForDb(string dbName)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[dbName]].ConnectionString
                    .UnProtect('_');
            switch (ConfigurationManager.ConnectionStrings[dbName].ProviderName)
            {
                case "MySql.Data.MySqlClient":
                    switch (dbName)
                    {
                        case CcToolDataContext.Cc:
                            return new CcToolDataContext(connectionString);
                        default:
                            return new AdHocMySqlDataContext(connectionString);
                    }
                default:
                    throw new ArgumentException("data provider {0} is not a valid data context",
                        ConfigurationManager.ConnectionStrings[dbName].ProviderName);
            }
        }
    }
}