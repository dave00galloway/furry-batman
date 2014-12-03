using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using FluentAssertions;
using System;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisHubAdminSelfTestSteps : CnxHubAdminStepBase
    {
        public new static readonly string FullName = typeof(Cnx2RedisHubAdminSelfTestSteps).FullName; 
        public Cnx2RedisHubAdminSelfTestSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter)
            : base(cnxTradeTableDataContext, cnxHubTradeActivityImporter)
        {
        }

        [Then(@"the list of included logins contains (.*) logins")]
        public void ThenTheListOfIncludedLoginsContainsLogins(int loginCount)
        {
            IncludedLoginsList.Should().HaveCount(loginCount);
        }

        [Then(@"all retrieved deals will have a client id from the included logins list")]
        public void ThenAllRetrievedDealsWillHaveAClientIdFromTheIncludedLoginsList()
        {
            foreach (Deal deal in QDF.UIClient.Tests.Steps.StepCentral.RedisConnectionHelper.RetrievedDeals)
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