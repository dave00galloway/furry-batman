using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using BoDi;
using BookSleeve;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QDF.UIClient.Tests.Steps.StepCentral;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    [Binding]
    public class Cnx2RedisHooks
    {
        private const string TradeTableDataContextName = "tradeTableDataContext";
        private const string MySqlTradeSchemaTableName = "MySqlTradeSchemaTable";
        private const string LocalHostIp = "127.0.0.1";
        private const string RedisLocalHostName = "redisLocalhost";
        private const string MySqlLocalhostName = "MySqlLocalhost";
        private static string[] _featureTags;
        private static string[] _scenarioTags;
        private IObjectContainer ObjectContainer { get; set; }

        [BeforeScenario]
        public void BeforeScenario()
        {
            _featureTags = FeatureContext.Current.FeatureInfo.Tags;
            _scenarioTags = ScenarioContext.Current.ScenarioInfo.Tags;
            SetupCnxTradeTableDataContext();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
            SeedDataIfLocalHost();
        }

        [AfterScenario]
        public void AfterScenario()
        {
            TeardownCnxTradeTableDataContext();
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
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }

        private void SetupCnxTradeTableDataContext()
        {
            string connectionString;
            if (_featureTags.Contains(MySqlLocalhostName) || _scenarioTags.Contains(MySqlLocalhostName))
            {
                connectionString =
                    ConfigurationManager.ConnectionStrings[MySqlLocalhostName]
                        .ConnectionString.UnProtect('_');
            }
            else
            {
                connectionString =
                    ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[TradeTableDataContextName]]
                        .ConnectionString.UnProtect('_');
            }

            var cnxTradeTable = new CnxTradeTableDataContext(connectionString,
                ConfigurationManager.AppSettings[MySqlTradeSchemaTableName]);
            ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof (IObjectContainer)) as IObjectContainer;
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(cnxTradeTable);
        }

        private static void SeedDataIfLocalHost()
        {
            if (_featureTags.Contains(RedisLocalHostName) || _scenarioTags.Contains(RedisLocalHostName))
            {
                RedisConnectionHelper redisConnection = StepCentral
                    .ResetRedisConnection(LocalHostIp);
                //paranoid double check to make sure not deleting a production or UAT db
                if (redisConnection.Connection.Host == LocalHostIp)
                {
                    redisConnection.Connection.Server.FlushAll();
                    LoadTestDataForTags(_featureTags, redisConnection.Connection);
                    LoadTestDataForTags(_scenarioTags, redisConnection.Connection);
                }
            }
        }

        private static void LoadTestDataForTags(IEnumerable<string> tags, RedisConnection connection)
        {
            foreach (string tag in tags)
            {
                if (!tag.Contains(":")) continue;
                var redisDataImport = new RedisDataImport(tag, connection);
                redisDataImport.ImportData();
            }
        }

        private void TeardownCnxTradeTableDataContext()
        {
            try
            {
                var cnxTradeTable = ObjectContainer.Resolve<CnxTradeTableDataContext>();
                if (cnxTradeTable.MyConnection.State != ConnectionState.Closed)
                {
                    cnxTradeTable.MyConnection.Close();
                }
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger();
            }
        }
    }
}