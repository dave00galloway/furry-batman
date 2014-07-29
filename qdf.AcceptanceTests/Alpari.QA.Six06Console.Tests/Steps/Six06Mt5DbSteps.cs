using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.QDF.Test.Domain.MT5;
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
            var newDeals = DealsDataContext.SelectDataAsDataTable(DealsDataContext.NewDealsQuery(LoginId,DealId));
            DealId = GetHighestDealIdForLogin(LoginId);
        }


        [Then(@"The highest mt5 deal id is greater than (.*)")]
        public void ThenTheHighestDealIdIsGreaterThan(ulong minValue)
        {
            DealId.Should().BeGreaterOrEqualTo(minValue);
        }

        [Then(@"the new highest mt5 deal id is greater than the original")]
        public void ThenTheNewHighestMtDealIdIsGreaterThanTheOriginal()
        {
            var old = DealId;
            WhenIGetTheHighestMtDealIdForMyLogin();
            DealId.Should().BeGreaterThan(old);
        }


    }
}
