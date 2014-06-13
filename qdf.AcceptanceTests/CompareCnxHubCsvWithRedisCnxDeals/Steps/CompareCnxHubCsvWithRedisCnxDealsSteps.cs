using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using CompareCnxHubCsvWithRedisCnxDeals.Helpers;
using TechTalk.SpecFlow;

namespace CompareCnxHubCsvWithRedisCnxDeals.Steps
{
    [Binding]
    public class CompareCnxHubCsvWithRedisCnxDealsSteps
    {
        [Given(@"I have loaded cnx hub data from ""(.*)""")]
        public void GivenIHaveLoadedCnxHubDataFrom(string filenamePath)
        {
            var cnxDeals = filenamePath.CsvToList<CnxHubDeal>(",");
        }

    }

}
