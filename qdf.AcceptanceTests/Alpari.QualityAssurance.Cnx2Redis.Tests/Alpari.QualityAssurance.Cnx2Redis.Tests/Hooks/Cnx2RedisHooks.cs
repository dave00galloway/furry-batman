using System.Linq;
using Alpari.QDF.UIClient.Tests.Steps;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using BoDi;
using System;
using System.Configuration;
using System.Data;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QDF.UIClient.Tests.Steps.StepCentral;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    [Binding]
    public class Cnx2RedisHooks 
    {
        private const string TradeTableDataContextName = "tradeTableDataContext";
        private const string MySqlTradeSchemaTableName = "MySqlTradeSchemaTable";
        private IObjectContainer ObjectContainer { get; set; }

        [BeforeScenario]
        public void BeforeScenario()
        {
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
            string connectionString =
                ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[TradeTableDataContextName]].ConnectionString.UnProtect('_');
            var cnxTradeTable = new CnxTradeTableDataContext(connectionString, ConfigurationManager.AppSettings[MySqlTradeSchemaTableName]);
            ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof(IObjectContainer)) as IObjectContainer;
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(cnxTradeTable);
        }

        private static void SeedDataIfLocalHost()
        {
            if (ScenarioContext.Current.ScenarioInfo.Tags.Contains("localhost") || FeatureContext.Current.FeatureInfo.Tags.Contains("localhost"))
            {
                var redisConnection = StepCentral
                    .ResetRedisConnection("127.0.0.1");
                //paranoid double check to make sure not deleting a production or UAT db
                if (redisConnection.Connection.Host == "127.0.0.1")
                {
                    redisConnection.Connection.Server.FlushAll();
                }
                
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
