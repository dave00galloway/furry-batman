using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using CompareCnxHubCsvWithRedisCnxDeals.Helpers;
using NUnit.Framework;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace CompareCnxHubCsvWithRedisCnxDeals.Steps
{
    [Binding]
    public class CompareCnxHubCsvWithRedisCnxDealsSteps
    {
        private string REDIS_HOST = "redisHost";
        private DealSearchCriteria DealSearchCriteria { get; set; }
        private RedisConnectionHelper RedisConnectionHelper { get; set; }
        private CnxHubDealQdfDealReconciler CnxHubDealQdfDealReconciler { get; set; }
        private List<CnxHubDeal> CnxHubDealList { get; set; }

        [StepArgumentTransformation]
        public static DealSearchCriteria DealSearchParametersTransform(Table table)
        {
            return table.CreateInstance<DealSearchCriteria>();
        }

        [BeforeScenario]
        public void Setup()
        {
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]);
            
        }

        [Given(@"I have loaded cnx hub data from ""(.*)""")]
        public void GivenIHaveLoadedCnxHubDataFrom(string filenamePath)
        {
            CnxHubDealList = filenamePath.CsvToList<CnxHubDeal>(",");
        }


        [Given(@"I have the following search criteria for qdf deals")]
        public void GivenIHaveTheFollowingSearchCriteriaForQdfDeals(DealSearchCriteria dealSearchCriteria)
        {
            DealSearchCriteria = dealSearchCriteria;
        }

        [When(@"I retrieve the qdf deal data")]
        public void WhenIRetrieveTheQdfDealData()
        {
            RedisConnectionHelper.RedisDealSearches.GetDealData(DealSearchCriteria);
        }

        [When(@"I compare the cnx hub data and the qdf deals")]
        public void WhenICompareTheCnxHubDataAndTheQdfDeals()
        {
            CnxHubDealQdfDealReconciler = new CnxHubDealQdfDealReconciler(RedisConnectionHelper.RetrievedDeals,
                CnxHubDealList);
            CnxHubDealQdfDealReconciler.Compare();
        }
        

        [Then(@"cnx hub deals missing from qdf deals are output to ""(.*)""")]
        public void ThenCnxHubDealsMissingFromQdfDealsAreOutputTo(string filenamePath)
        {
            CnxHubDealQdfDealReconciler.MissingCnxHubDeals.EnumerableToCsv(filenamePath,true);
        }


        [AfterScenario]
        public void TearDown()
        {
            RedisConnectionHelper.Connection.Close(false);
        }
        
    }

}
