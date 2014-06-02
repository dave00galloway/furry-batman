﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfDataRetrievalStepBase : StepCentral
    {
        public const string SERVER_TABLE_KEY = "Server";
        public const string COUNT = "Count";
        public const string SYMBOL_TABLE_KEY = "Symbol";

        public static readonly string FullName = typeof(QdfDataRetrievalStepBase).FullName;
        


        [StepArgumentTransformation]
        public static DealSearchCriteria DiffDeltaParametersTransform(Table table)
        {
            return table.CreateInstance<DealSearchCriteria>();
        }

        /// <summary>
        /// Not sure I like these older methods for verifying, but they will pick up multiple errors rather than just failing on the first.
        /// Need to write a genric validate set method
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        protected string GetVerificationErrorsForServerCounts(Table table)
        {
            var expected = DataTableOperations.GetTableAsList(table);
            var actual = new List<IDictionary<string, object>>();
            var groupedByServer = RedisConnectionHelper.RetrievedDeals.GroupBy(x => x.Server);
            foreach (IGrouping<TradingServer, Deal> grouping in groupedByServer)
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

        protected string GetVerificationErrorsForSymbolCounts(Table table)
        {
            var expected = DataTableOperations.GetTableAsList(table);
            var actual = new List<IDictionary<string, object>>();
            var groupedBySymbol = RedisConnectionHelper.RetrievedDeals.GroupBy(x => x.Instrument);
            foreach (IGrouping<string, Deal> grouping in groupedBySymbol)
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

    }
}
