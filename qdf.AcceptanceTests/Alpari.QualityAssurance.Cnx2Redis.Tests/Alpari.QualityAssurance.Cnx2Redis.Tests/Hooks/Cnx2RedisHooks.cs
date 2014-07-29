using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using BoDi;
using BookSleeve;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QDF.UIClient.Tests.Steps.StepCentral;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    [Binding]
    public class Cnx2RedisHooks : SpecFlowExtensionsHooks
    {
        private const string TradeTableDataContextName = "tradeTableDataContext";
        private const string MySqlTradeSchemaTableName = "MySqlTradeSchemaTable";
        private const string LocalHostIp = "127.0.0.1";
        private const string RedisLocalHostName = "redisLocalhost";
        private const string MySqlLocalhostName = "MySqlLocalhost";
        private const string CnxHubTradeActivityImporterName = "cnxHubTradeActivityImporter";
        private const string RedisDataImportParams = "RedisDataImportParams:";

        [BeforeScenario]
        public void BeforeScenario()
        {
            //ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof(IObjectContainer)) as IObjectContainer;
            //_featureTags = FeatureContext.Current.FeatureInfo.Tags;
            //_scenarioTags = ScenarioContext.Current.ScenarioInfo.Tags;
            SetupObjectContainerAndTagsProperties();
            SetupCnxTradeTableDataContext();
            SetupGetTradeswithEventIdDataContext();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
            SeedDataIfLocalHost();
            SetupCnxHubTradeActivityImporter();
        }

        [AfterScenario]
        public void AfterScenario()
        {
            TeardownCnxTradeTableDataContext();
            TeardownGetTradeswithEventIdDataContext();
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

        /// <summary>
        /// todo:- use tags to establish if this is needed?
        /// todo:- add config to app.config if not running on Dev?
        /// </summary>
        private void SetupGetTradeswithEventIdDataContext()
        {
            var getTradeswithEventIdDataContext = new GetTradeswithEventIDDataContext();
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(getTradeswithEventIdDataContext);
        }

        /// <summary>
        /// TODO:- enable override of MySqlTradeSchemaTableName from tags
        /// </summary>
        private void SetupCnxTradeTableDataContext()
        {
            string connectionString;
            //if (FeatureTags.Contains(MySqlLocalhostName) || ScenarioTags.Contains(MySqlLocalhostName))
            if (TagDependentAction(MySqlLocalhostName))
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
            if (FeatureTags.Contains(RedisLocalHostName) || ScenarioTags.Contains(RedisLocalHostName))
            {
                RedisConnectionHelper redisConnection = StepCentral
                    .ResetRedisConnection(LocalHostIp);
                //paranoid double check to make sure not deleting a production or UAT db
                if (redisConnection.Connection.Host == LocalHostIp)
                {
                    redisConnection.Connection.Server.FlushAll();
                    LoadTestDataForTags(FeatureTags, redisConnection.Connection);
                    LoadTestDataForTags(ScenarioTags, redisConnection.Connection);
                }
            }
        }

        private static void LoadTestDataForTags(IEnumerable<string> tags, RedisConnection connection)
        {
            foreach (string tag in tags)
            {
                if (!tag.Contains(RedisDataImportParams)) continue;
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
                    cnxTradeTable.MyConnection.Dispose();
                }
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger();
            }
        }

        private void TeardownGetTradeswithEventIdDataContext()
        {
            try
            {
                var context = ObjectContainer.Resolve<GetTradeswithEventIDDataContext>();
                if (context.Connection.State != ConnectionState.Closed)
                {
                    context.Connection.Close();
                    context.Dispose();
                }
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger();
            }
        }

        private static void SetupCnxHubTradeActivityImporter()
        {
            if (LoadCnxHubTradeActivityImporter(ScenarioTags))
            {
                return;
            }
            LoadCnxHubTradeActivityImporter(FeatureTags);
        }

        private static bool LoadCnxHubTradeActivityImporter(IEnumerable<string> tags)
        {
            var tagArray = tags as string[] ?? tags.ToArray();
            if (!tagArray.Any(x => x.Contains(CnxHubTradeActivityImporterName))) return false;
            var importer = CnxHubTradeActivityImporterFactory.Create(
                tagArray.First(x => x.Contains(CnxHubTradeActivityImporterName)));
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(importer);
            return true;
        }
    }
}