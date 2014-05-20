using System;
using System.Collections.Generic;
using System.Configuration;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using qdf.AcceptanceTests.TypedDataTables;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationStepBase :StepCentral
    {
        public const string QDF_DEAL_DATA = "QdfDealData";
        public const string CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS = "CcToolDataTable";
        public const string CC_TOOL_DATA_TABLE = "CcToolDataTable";
        public const string REPORT_ROOT = "reportRoot";
        public const string MY_SQL_QUERY_TIMEOUT = "MySqlQueryTimeout";
        public const string DEFAULT_START_TIME = "defaultStartTime";
        public const string DEFAULT_END_TIME = "defaultEndTime";
        public const string DEFAULT_CONNECTION_STRING = "defaultConnectionString";
        public const string REDIS_HOST = "redisHost";
        public const string ALL_QDF_DEALS_CSV = "AllQdfDeals.csv";
        public const string CCTOOL_DATA_CSV = "CcToolData.csv";


        public static readonly string FullName = typeof (DealReconciliationStepBase).FullName;
        public const string SCENARIO_OUTPUT_DIRECTORY = "ScenarioOutputDirectory";
        protected RedisConnectionHelper RedisConnectionHelper { get; set; }
        protected IDataContextSubstitute ContextSubstitute { get; set; }
        protected QdfDealParameters QdfDealParameters { get; set; }

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeFeature("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeFeature]
        public static void BeforeFeature()
        {
            FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY] = ConfigurationManager.AppSettings[REPORT_ROOT] +
                                                               TestRunContext.StaticFriendlyTime + @"\" +
                                                               FeatureContext.Current.FeatureInfo.Title.Replace(" ", "") +
                                                               @"\";
            ((string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY]).ClearOutputDirectory();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            TestRunContext.Instance[TEST_RUN_CONTEXT] = TestRunContext.Instance;
            TestRunContext.Instance[MY_SQL_QUERY_TIMEOUT] = ConfigurationManager.AppSettings[MY_SQL_QUERY_TIMEOUT];
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
            ScenarioContext.Current[SCENARIO_OUTPUT_DIRECTORY] =
                (string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY] +
                ScenarioContext.Current.ScenarioInfo.Title.Replace(" ", "") + @"\";
            (ScenarioOutputDirectory).ClearOutputDirectory();
        }

        /// <summary>
        /// TODO:- move to MasterStepBase, add setter and bypass ScenarioContext altogether?
        /// </summary>
        public static string ScenarioOutputDirectory
        {
            get { return (string)ScenarioContext.Current[SCENARIO_OUTPUT_DIRECTORY]; }
        }

        /// <summary>
        /// TODO:- move to MasterStepBase, add setter and bypass FeatureContext altogether?
        /// </summary>
        protected static string FeatureOutputDirectory
        {
            get { return (string)FeatureContext.Current[FEATURE_OUTPUT_DIRECTORY]; }
        }

        protected static int MySqlQueryTimeout
        {
            get { return Convert.ToInt32(TestRunContext.Instance[MY_SQL_QUERY_TIMEOUT]); }
        }

        public static void SetupQdfDealQuery(QdfDealParameters entry)
        {
            string start = entry.StartTime ?? ConfigurationManager.AppSettings[DEFAULT_START_TIME];
            string end = entry.EndTime ?? ConfigurationManager.AppSettings[DEFAULT_END_TIME];
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

        protected static IDataContextSubstitute GetDataContextSubstitute(string dataContext)
        {
            switch (dataContext)
            {
                case "MySqlDataContextSubstitute":
                    return
                        new CcToolDataContext(
                            ConfigurationManager.ConnectionStrings[
                                ConfigurationManager.AppSettings[DEFAULT_CONNECTION_STRING]].ConnectionString.UnProtect(
                                    '_'));
                case "QuickStartMySqlDataContext":
                    //QuickStartMySqlDataContext context = new QuickStartMySqlDataContext();
                    throw new ArgumentException("data context {0} is licensed and there is no license available",
                        dataContext);
                default:
                    throw new ArgumentException("data context {0} is not a valid data context", dataContext);
            }
        }

        protected static IDataContextSubstitute GetDataContextSubstituteForDb(string dbName)
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

        protected static CcToolDataTable GetDailySnapshotDataFromDateRange(string start, string end, IDataContextSubstitute contextSubstitute)
        {
            var startDate = start.GetTimeFromShortCode();
            var endDate = end.GetTimeFromShortCode(startDate);
            return GetDailySnapshotDataFromDateRange(startDate, endDate, contextSubstitute);
        }

        protected static CcToolDataTable GetDailySnapshotDataFromDateRange(DateTime startDate, DateTime endDate, IDataContextSubstitute contextSubstitute)
        {
            var ccToolDataTable = new CcToolDataTable();
            int days = endDate.Subtract(startDate).Days;
            for (int i = 0; i < days; i++)
            {
                var date = (DateTime)contextSubstitute.SelectDataAsDataTable(CcToolDataContext.CcDailySnapshotTimeQuery(startDate.AddDays(i)), MySqlQueryTimeout).Rows[0]["UpdateDateTime"];
                var ccToolData =
                    contextSubstitute.SelectDataAsDataTable(CcToolDataContext.CcToolQuery(date,
                        date), MySqlQueryTimeout).ConvertToTypedDataTable<CcToolDataTable>();
                ccToolDataTable.Merge(ccToolData);
                ccToolData.Clear();
                ccToolDataTable.AcceptChanges();
            }
            return ccToolDataTable;
        }

        protected void LoadQdfDealsForParameters(QdfDealParameters qdfDealParameters)
        {
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]);
            SetupQdfDealQuery(qdfDealParameters);
            RedisConnectionHelper.GetDealData(qdfDealParameters);
            QdfDealParameters = qdfDealParameters;
            ScenarioContext.Current[QDF_DEAL_DATA] = RedisConnectionHelper.RetrievedDeals;
        }

        protected void OutputQdfDeals(string outputTo)
        {
            //added a try catch here to cope with changes in QDF Deal format
            try
            {
                RedisConnectionHelper.OutputAllDeals(outputTo +
                                                     ALL_QDF_DEALS_CSV);
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger();
            }
        }

        protected CcToolDataTable LoadCcToolDataForParameters()
        {
            ContextSubstitute = GetDataContextSubstituteForDb(CcToolDataContext.Cc);
            var ccToolData =
                ContextSubstitute.SelectDataAsDataTable(CcToolDataContext.CcToolQuery(QdfDealParameters.ConvertedStartTime,
                    QdfDealParameters.ConvertedEndTime), MySqlQueryTimeout).ConvertToTypedDataTable<CcToolDataTable>();
            //get server and spread combos as a demo
            //CCToolDataContext.OutputCalculatedSpread(ccToolData);
            /*undecided whether to use properties for this data. 
             * with the QDF data, there always willbe some, 
             * but for the ars/cnx/ecn data there might or might not be 
             * maybe the base class should hold properties for QDF, and specialised subclasses should hold properties for comparing with the QDF data
             * */
            ScenarioContext.Current[CC_TOOL_DATA_TABLE] = ccToolData;
            return ccToolData;
        }

        protected CcToolDataTable LoadCcToolDailySnapshotData(string startDate, string endDate)
        {
            ContextSubstitute = GetDataContextSubstituteForDb(CcToolDataContext.Cc);
            CcToolDataTable ccToolDataTable;
            if (FeatureContext.Current.ContainsKey(CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS))
            {
                ccToolDataTable = FeatureContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] as CcToolDataTable;
                ScenarioContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
            }
            else
            {
                ccToolDataTable = GetDailySnapshotDataFromDateRange(startDate,
                    endDate, ContextSubstitute);
                ScenarioContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
                FeatureContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
            }
            return ccToolDataTable;
        }

        protected CcToolDataTable LoadCcToolDailySnapshotData(DateTime startDate, DateTime endDate)
        {
            ContextSubstitute = GetDataContextSubstituteForDb(CcToolDataContext.Cc);
            CcToolDataTable ccToolDataTable;
            if (FeatureContext.Current.ContainsKey(CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS))
            {
                ccToolDataTable = FeatureContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] as CcToolDataTable;
                ScenarioContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
            }
            else
            {
                ccToolDataTable = GetDailySnapshotDataFromDateRange(startDate,
                    endDate, ContextSubstitute);
                ScenarioContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
                FeatureContext.Current[CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS] = ccToolDataTable;
            }
            return ccToolDataTable;
        }


        protected static void OutputCcToolDataIfNew(CcToolDataTable ccToolData)
        {
            if (!FeatureContext.Current.ContainsKey(CC_TOOL_DATA_TABLE_DAILY_SNAPSHOTS)) 
            {
                OutputCcToolData(ccToolData, FeatureOutputDirectory);
            }
        }

        protected static void OutputCcToolData(CcToolDataTable ccToolData, string outputTo)
        {
            ccToolData.ExportData(ExportTypes.Csv, new[] { String.Format("{0}{1}", outputTo,CCTOOL_DATA_CSV) });
        }

        [AfterScenario]
        public void Teardown()
        {
            if (RedisConnectionHelper != null)
            {
                //try
                //{
                //removed try/catch as might as well see full stack trace - this is likely to be the last operation
                RedisConnectionHelper.Connection.Close(true);
                //}
                //catch (Exception e)
                //{
                //    Console.WriteLine(e.Message);
                //}
            }
        }
    }
}