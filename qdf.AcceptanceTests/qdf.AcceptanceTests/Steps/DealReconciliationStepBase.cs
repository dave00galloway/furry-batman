using System;
using System.Collections.Generic;
using System.Configuration;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationStepBase
    {
        public static void SetupQdfDealQuery(QdfDealParameters entry)
        {
            var start = entry.StartTime ?? ConfigurationManager.AppSettings["defaultStartTime"];
            var end = entry.EndTime ?? ConfigurationManager.AppSettings["defaultEndTime"];
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
            var connectionString =
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