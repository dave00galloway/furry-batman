using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public const string REDIS_HOST = "redisHost";
        public const string SERVER_TABLE_KEY = "Server";
        public const string COUNT = "Count";
        public const string SYMBOL_TABLE_KEY = "Symbol";

        private static RedisConnectionHelper _redisConnectionHelper;

        protected RedisConnectionHelper RedisConnectionHelper
        {
            get
            {
                if (_redisConnectionHelper != null) return _redisConnectionHelper;
                _redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]);
                ObjectContainer.RegisterInstanceAs(_redisConnectionHelper);
                return _redisConnectionHelper;
            }
        }

        protected QdfDataRetrievalStepBase QdfDataRetrievalStepBase
        {
            get
            {
                bool toAdd = GetStepDefinition(QdfDataRetrievalStepBase.FullName) == null;
                QdfDataRetrievalStepBase steps = (QdfDataRetrievalStepBase)
                    GetStepDefinition(QdfDataRetrievalStepBase.FullName) ??
                                                 new QdfDataRetrievalStepBase();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected QdfDataRetrievalSteps QdfDataRetrievalSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(QdfDataRetrievalSteps.FullName) == null;
                QdfDataRetrievalSteps steps = (QdfDataRetrievalSteps)
                    GetStepDefinition(QdfDataRetrievalSteps.FullName) ??
                                              new QdfDataRetrievalSteps();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected OutputToCsvStepBase OutputToCsvStepBase
        {
            get
            {
                bool toAdd = GetStepDefinition(OutputToCsvStepBase.FullName) == null;
                OutputToCsvStepBase steps = (OutputToCsvStepBase)
                    GetStepDefinition(OutputToCsvStepBase.FullName) ??
                                              new OutputToCsvStepBase(new Exporter(RedisConnectionHelper));
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;                
            }
        }

        protected OutputToCsvSteps OutputToCsvSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(OutputToCsvSteps.FullName) == null;
                OutputToCsvSteps steps = (OutputToCsvSteps)
                    GetStepDefinition(OutputToCsvSteps.FullName) ??
                                              new OutputToCsvSteps(new Exporter(RedisConnectionHelper));
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        /// <summary>
        ///     Not sure I like these older methods for verifying, but they will pick up multiple errors rather than just failing
        ///     on the first.
        ///     Need to write a genric validate set method
        /// </summary>
        /// <param name="table"></param>
        /// <param name="dealList"></param>
        /// <returns></returns>
        protected string VerificationErrorsForServerCounts(Table table, IEnumerable<Deal> dealList)
        {
            IList<IDictionary<string, object>> expected = DataTableOperations.GetTableAsList(table);
            var actual = new List<IDictionary<string, object>>();
            IEnumerable<IGrouping<TradingServer, Deal>> groupedByServer = dealList.GroupBy(x => x.Server);
            foreach (var grouping in groupedByServer)
            {
                var count = new Dictionary<string, object>
                {
                    {SERVER_TABLE_KEY, grouping.Key.ToString()},
                    {COUNT, grouping.Count()}
                };
                actual.Add(count);
            }
            string verificationErrors = DataTableOperations.VerifyTables(SERVER_TABLE_KEY,
                new ExpectedAndActualIDictionariesAsIlIsts(expected, actual));

            verificationErrors += DataTableOperations.VerifyTables(SERVER_TABLE_KEY,
                new ExpectedAndActualIDictionariesAsIlIsts(actual, expected));
            return verificationErrors;
        }

        protected string VerificationErrorsForSymbolCounts(Table table, IEnumerable<Deal> dealList)
        {
            IList<IDictionary<string, object>> expected = DataTableOperations.GetTableAsList(table);
            var actual = new List<IDictionary<string, object>>();
            IEnumerable<IGrouping<string, Deal>> groupedBySymbol = dealList.GroupBy(x => x.Instrument);
            foreach (var grouping in groupedBySymbol)
            {
                var count = new Dictionary<string, object>
                {
                    {SYMBOL_TABLE_KEY, grouping.Key},
                    {COUNT, grouping.Count()}
                };
                actual.Add(count);
            }
            string verificationErrors = DataTableOperations.VerifyTables(SYMBOL_TABLE_KEY,
                new ExpectedAndActualIDictionariesAsIlIsts(expected, actual));

            verificationErrors += DataTableOperations.VerifyTables(SYMBOL_TABLE_KEY,
                new ExpectedAndActualIDictionariesAsIlIsts(actual, expected));
            return verificationErrors;
        }

        [AfterScenario]
        public void TearDown()
        {
            if (_redisConnectionHelper != null)
            {
                RedisConnectionHelper.Connection.Close(true);
                _redisConnectionHelper = null;
            }
        }
    }
}