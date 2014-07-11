using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminSteps : CnxHubAdminStepBase
    {
        public new static readonly string FullName = typeof(CnxHubAdminSteps).FullName; 
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

        [When(@"I update the qdf deal criteria with start and end times")]
        public void WhenIUpdateTheQdfDealCriteriaWithStartAndEndTimes()
        {
            DealSearchCriteria criteria = QdfDataRetrievalSteps.DealSearchCriteria;
            criteria.ConvertedStartTime = CnxHubTradeActivityImporter.EarliestTradeActivityDateTime;
            //need to add 1 tick to the end time as the precision of the cnx Hub times stops at seconds
            criteria.ConvertedEndTime = CnxHubTradeActivityImporter.LatestTradeActivityDateTime + new TimeSpan((long)1);
        }

        [When(@"I filter the qdf deals by the included logins")]
        public void WhenIFilterTheQdfDealsByTheIncludedLogins()
        {
            QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals =
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.Where(
                    deal =>
                        IncludedLoginsList.Any(
                            l =>
                                String.Equals(l.Login.Trim(), deal.ClientId.Trim(),
                                    StringComparison.InvariantCultureIgnoreCase))).ToList();
        }

        [When(@"I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins")]
        public void WhenIRetrieveTheQdfDealDataFilteredByCnxHubStartAndEndTimesAndByIncludedLogins()
        {
            WhenIUpdateTheQdfDealCriteriaWithStartAndEndTimes();
            QdfDataRetrievalSteps.WhenIRetrieveTheQdfDealData();
            WhenIFilterTheQdfDealsByTheIncludedLogins();
        }

    }
}