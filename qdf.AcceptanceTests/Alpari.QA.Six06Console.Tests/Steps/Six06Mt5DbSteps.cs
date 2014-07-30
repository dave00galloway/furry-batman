using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QA.Six06Console.Tests.DomainObjects;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06Mt5DbSteps : Six06Mt5DbStepBase
    {
        public Six06Mt5DbSteps(DealsDataContext dealsDataContext) : base(dealsDataContext)
        {
        }

        [Given(@"I am using mt5 manager login '(.*)'")]
        public void GivenIAmUsingMtManagerLogin(ulong loginId)
        {
            LoginId = loginId;
        }

        [Given(@"I have stored the highest mt5 deal id for login '(.*)'")]
        public void GivenIHaveStoredTheHighestMtDealIdForLogin(ulong loginId)
        {
            GivenIAmUsingMtManagerLogin(loginId);
            DealId = GetHighestDealIdForLogin(LoginId);
        }

        [When(@"I get the highest mt5 deal id for my login")]
        public void WhenIGetTheHighestMtDealIdForMyLogin()
        {
            DealId = GetHighestDealIdForLogin(LoginId);
        }

        [When(@"I query the mt5 deals table for new deals for my login")]
        public void WhenIQueryTheMtDealsTableForNewDealsForMyLogin()
        {
            Mt5Deals =
                DealsDataContext.SelectDataAsDataTable(DealsDataContext.NewDealsQuery(LoginId, DealId))
                    .ConvertToTypedDataTable<DealsDataTable>();
            DealId = GetHighestDealIdForLogin(LoginId);
        }

        [When(@"I convert the mt5 deals to trades with event id")]
        public void WhenIConvertTheMtDealsToTradesWithEventId()
        {
            ConvertedMt5Deals = Mt5Deals.ConvertMt5DealsDataTable(Six06ConsoleAppSteps.OrderEventIdToDealMapping);
        }


        [Then(@"The highest mt5 deal id is greater than (.*)")]
        public void ThenTheHighestDealIdIsGreaterThan(ulong minValue)
        {
            DealId.Should().BeGreaterOrEqualTo(minValue);
        }

        [Then(@"the new highest mt5 deal id is greater than the original")]
        public void ThenTheNewHighestMtDealIdIsGreaterThanTheOriginal()
        {
            ulong old = DealId;
            WhenIGetTheHighestMtDealIdForMyLogin();
            DealId.Should().BeGreaterThan(old);
        }

        /// <summary>
        ///     Note - this only tells us that all deals that were converted by the console app have been mapped, not that they
        ///     have all been imported from QDF!
        /// </summary>
        [Then(@"all order events in the order event id to deal mapping dictionary are mapped")]
        public void ThenAllOrderEventsInTheOrderEventIdToDealMappingDictionaryAreMapped()
        {
            foreach (
                bool found in
                    Six06ConsoleAppSteps.OrderEventIdToDealMapping.Keys.Select(
                        key =>
                            ConvertedMt5Deals.Rows.Cast<TradeWithEventIdWithDealAndOrderDataTableRow>()
                                .Any(row => row.OrderEventId == key)))
            {
                found.Should().Be(true);
            }
        }
    }
}