using System;
using System.Linq;
using Alpari.QDF.UIClient.App.Annotations;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisHubAdminWorkaroundSteps : CnxHubAdminStepBase
    {
        public new static readonly string FullName = typeof (Cnx2RedisHubAdminWorkaroundSteps).FullName;

        public Cnx2RedisHubAdminWorkaroundSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter)
            : base(cnxTradeTableDataContext, cnxHubTradeActivityImporter)
        {
        }

        [StepArgumentTransformation]
        public static TradeActivityWorkAroundParams TradeActivityWorkAroundTransform(Table table)
        {
            return table.CreateInstance<TradeActivityWorkAroundParams>();
        }

        [When(@"I load cnx trade activities from")]
        public void WhenILoadCnxTradeActivitiesFrom(TradeActivityWorkAroundParams tradeActivityWorkAroundParams)
        {
            CnxHubAdminSteps.WhenILoadCnxTradeActivitiesFrom(tradeActivityWorkAroundParams.FileNamePath);
            CnxHubTradeActivityImporter.CnxTradeActivityList = CnxHubTradeActivityImporter.CnxTradeActivityList
                .Where(
                    x =>
                        x.TradeDateGMT >= tradeActivityWorkAroundParams.ConvertedStartTime &&
                        x.TradeDateGMT <= tradeActivityWorkAroundParams.ConvertedEndTime).ToList();
            CnxHubTradeActivityImporter.UpdateStartAndEndTimes(tradeActivityWorkAroundParams.ConvertedStartTime, tradeActivityWorkAroundParams.ConvertedEndTime);
        }

        [When(@"I load cnx trade activities with the side reversed for the included logins from")]
        public void WhenILoadCnxTradeActivitiesWithTheSideReversedForTheIncludedLoginsFrom(TradeActivityWorkAroundParams tradeActivityWorkAroundParams)
        {
            WhenILoadCnxTradeActivitiesForTheIncludedLoginsFrom(tradeActivityWorkAroundParams);
            CnxHubTradeActivityImporter.ReverseDealSide();
        }


        [When(@"I load cnx trade activities for the included logins from")]
        public void WhenILoadCnxTradeActivitiesForTheIncludedLoginsFrom(
            TradeActivityWorkAroundParams tradeActivityWorkAroundParams)
        {
            CnxHubTradeActivityImporter.IncludedLoginsList = IncludedLoginsList;
            WhenILoadCnxTradeActivitiesFrom(tradeActivityWorkAroundParams);
        }
    }

    [UsedImplicitly]
    public class TradeActivityWorkAroundParams
    {
        public string FileNamePath { get; set; }
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
    }
}