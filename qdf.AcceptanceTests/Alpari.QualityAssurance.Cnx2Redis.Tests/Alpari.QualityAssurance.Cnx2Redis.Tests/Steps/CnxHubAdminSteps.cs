using System;
using System.Collections.Generic;
using System.Linq;
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
        public CnxHubAdminSteps(CnxTradeTableDataContext cnxTradeTableDataContext) : base(cnxTradeTableDataContext)
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
            CnxTradeActivityList = filenamePath.CsvToList<CnxTradeActivity>(",");
        }

        [When(@"I load cnx trade activities from ""(.*)"" for the selected logins")]
        public void WhenILoadCnxTradeActivitiesFromForTheSelectedLogins(string filenamePath)
        {
            //Move functionality to a helper class?
            //should work but doesn't! - no, wait... it does
            //CnxTradeActivityList =
            //    filenamePath.CsvToList<CnxTradeActivity>(",")
            //        .Where(x => IncludedLoginsList.Select(l => l.Login).Contains(x.Taker))
            //        .ToList();
            //this is probably more performant
            CnxTradeActivityList =
                filenamePath.CsvToList<CnxTradeActivity>(",").Where(
                    cnxTradeActivity =>
                        IncludedLoginsList.Any(includedLogin => cnxTradeActivity.Taker == includedLogin.Login)).ToList();

            CnxTradeActivityList.Sort((t1, t2) => DateTime.Compare(t1.TradeDateGMT, t2.TradeDateGMT));
            if (CnxTradeActivityList.Count <= 0) return;
            // ReSharper disable PossibleNullReferenceException
            EarliestTradeActivityDateTime = CnxTradeActivityList.FirstOrDefault().TradeDateGMT;
            LatestTradeActivityDateTime = CnxTradeActivityList.LastOrDefault().TradeDateGMT;
            // ReSharper restore PossibleNullReferenceException
        }


        [Then(@"the list of included logins contains (.*) logins")]
        public void ThenTheListOfIncludedLoginsContainsLogins(int loginCount)
        {
            IncludedLoginsList.Should().HaveCount(loginCount);
        }

        [Then(@"the count of loaded cnx trade activities is (.*)")]
        public void ThenTheCountOfLoadedCnxTradeActivitiesIs(int activityCount)
        {
            CnxTradeActivityList.Should().HaveCount(activityCount);
        }

        [Then(@"the earliest cnx trade activity is ""(.*)""")]
        public void ThenTheEarliestCnxTradeActivityIs(DateTime earlyDateTime)
        {
            EarliestTradeActivityDateTime.Should().Be(earlyDateTime);
        }

        [Then(@"the latest cnx trade activity is ""(.*)""")]
        public void ThenTheLatestCnxTradeActivityIs(DateTime lateDateTime)
        {
            LatestTradeActivityDateTime.Should().Be(lateDateTime);
        }
    }
}