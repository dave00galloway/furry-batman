using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using BoDi;
using System;
using System.Configuration;
using System.Data;
using TechTalk.SpecFlow;

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
        }

        [AfterScenario]
        public void AfterScenario()
        {
            TeardownCnxTradeTableDataContext();
        }

        private void SetupCnxTradeTableDataContext()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[TradeTableDataContextName]].ConnectionString.UnProtect('_');
            var cnxTradeTable = new CnxTradeTableDataContext(connectionString, ConfigurationManager.AppSettings[MySqlTradeSchemaTableName]);
            ObjectContainer = ScenarioContext.Current.GetBindingInstance(typeof(IObjectContainer)) as IObjectContainer;
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(cnxTradeTable);
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
