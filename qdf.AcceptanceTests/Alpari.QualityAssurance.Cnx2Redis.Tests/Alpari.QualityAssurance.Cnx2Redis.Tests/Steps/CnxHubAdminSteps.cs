using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QDF.UIClient.Tests.Steps;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminSteps : CnxHubAdminStepBase
    {
        public CnxHubAdminSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter)
            : base(cnxTradeTableDataContext, cnxHubTradeActivityImporter)
        {
        }

        [Given(@"I have this list of takers to load from cnx hub")]
        public void GivenIHaveThisListOfTakersToLoadFromCnxHub(IEnumerable<IncludedLogins> includedLogins)
        {
            IncludedLoginsList = includedLogins;
        }

        [When(@"I load cnx trade activities from ""(.*)""")]
        public void WhenILoadCnxTradeActivitiesFrom(string filenamePath)
        {
            CnxHubTradeActivityImporter.LoadData(new ExportParameters {FileName = filenamePath});
        }

        [When(@"I load cnx trade activities from ""(.*)"" for the included logins")]
        public void WhenILoadCnxTradeActivitiesFromForTheIncludedLogins(string filenamePath)
        {
            CnxHubTradeActivityImporter.IncludedLoginsList = IncludedLoginsList;
            WhenILoadCnxTradeActivitiesFrom(filenamePath);
        }

        [Then(@"the list of included logins contains (.*) logins")]
        public void ThenTheListOfIncludedLoginsContainsLogins(int loginCount)
        {
            IncludedLoginsList.Should().HaveCount(loginCount);
        }

        [When(@"I update the qdf deal criteria with start and end times")]
        public void WhenIUpdateTheQdfDealCriteriaWithStartAndEndTimes()
        {
            var criteria = QdfDataRetrievalSteps.DealSearchCriteria;
            criteria.ConvertedStartTime = CnxHubTradeActivityImporter.EarliestTradeActivityDateTime;
            criteria.ConvertedEndTime = CnxHubTradeActivityImporter.LatestTradeActivityDateTime;
        }

        [When(@"I filter the qdf deals by the included logins")]
        public void WhenIFilterTheQdfDealsByTheIncludedLogins()
        {
            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals =
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.Where(
                    deal =>
                        IncludedLoginsList.Any(
                            l => String.Equals(l.Login.Trim(), deal.ClientId.Trim(), StringComparison.InvariantCultureIgnoreCase))).ToList();
        }

        [Then(@"all retrieved deals will have a client id from the included logins list")]
        public void ThenAllRetrievedDealsWillHaveAClientIdFromTheIncludedLoginsList()
        {
            foreach (Deal deal in QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals)
            {
                IncludedLoginsList.Select(l => l.Login).Should().Contain(deal.ClientId);
            }
        }

        [Then(@"the count of loaded cnx trade activities is (.*)")]
        public void ThenTheCountOfLoadedCnxTradeActivitiesIs(int activityCount)
        {
            CnxHubTradeActivityImporter.CnxTradeActivityList.Should().HaveCount(activityCount);
        }

        [Then(@"the earliest cnx trade activity is ""(.*)""")]
        public void ThenTheEarliestCnxTradeActivityIs(DateTime earlyDateTime)
        {
            CnxHubTradeActivityImporter.EarliestTradeActivityDateTime.Should().Be(earlyDateTime);
        }

        [Then(@"the latest cnx trade activity is ""(.*)""")]
        public void ThenTheLatestCnxTradeActivityIs(DateTime lateDateTime)
        {
            CnxHubTradeActivityImporter.LatestTradeActivityDateTime.Should().Be(lateDateTime);
        }
    }
}