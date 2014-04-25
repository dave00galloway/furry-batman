using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Alpari.QualityAssurance.SpecFlowExtensions;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using Alpari.QualityAssurance.SecureMyPassword;
using System.Configuration;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationStepBase
    {
        public static void SetupQdfDealQuery(QdfDealParameters entry)
        {
            var start = entry.startTime != null ? entry.startTime : ConfigurationManager.AppSettings["defaultStartTime"];
            var end = entry.endTime != null ? entry.endTime : ConfigurationManager.AppSettings["defaultEndTime"];
            entry.convertedStartTime = start.GetTimeFromShortCode();
            entry.convertedEndTime = end.GetTimeFromShortCode(entry.convertedStartTime);
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
                    return new CCToolDataContext(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["defaultConnectionString"]].ConnectionString.UnProtect('_'));
                case "QuickStartMySqlDataContext":
                    //QuickStartMySqlDataContext context = new QuickStartMySqlDataContext();
                    throw new ArgumentException("data context {0} is licensed and there is no license available", dataContext);
                default:
                    throw new ArgumentException("data context {0} is not a valid data context", dataContext);
            }
        }

        public static IDataContextSubstitute GetDataContextSubstituteForDB(string dbName)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[dbName]].ConnectionString.UnProtect('_');
            switch (ConfigurationManager.ConnectionStrings[dbName].ProviderName)
            {
                case "MySql.Data.MySqlClient":                   
                    switch (dbName)
                    {
                        case MySqlDataContextSubstitute.CC:
                            return new CCToolDataContext(connectionString);
                        default:
                            return new AdHocMySqlDataContext(connectionString);
                    }
                default:
                    throw new ArgumentException("data provider {0} is not a valid data context", ConfigurationManager.ConnectionStrings[dbName].ProviderName);
            }
        }
    }
}
