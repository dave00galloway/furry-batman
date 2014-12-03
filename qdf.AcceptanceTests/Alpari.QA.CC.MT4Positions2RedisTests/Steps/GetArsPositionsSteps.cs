using Alpari.QA.QDF.Test.Domain.DataContexts.MT4;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class GetArsPositionsSteps : StepCentral
    {
        public new static readonly string FullName = typeof (GetArsPositionsSteps).FullName;

        public GetArsPositionsSteps(PositionsDataContext positionsDataContext,
            IDictionary<string, PositionDataTable> positionDataTableDictionary)
        {
            PositionsDataContext = positionsDataContext;
            PositionDataTableDictionary = positionDataTableDictionary;
        }

        public PositionsDataContext PositionsDataContext { get; set; }
        public IDictionary<string, PositionDataTable> PositionDataTableDictionary { get; set; }

        [Given(@"I have a connection to Mt4ArsPositionsContext")]
        public void GivenIHaveAConnectionToMtArsPositionsContext()
        {
            PositionsDataContext.Should().NotBeNull();
        }

        [When(@"I query for open positions after ""(.*)"" on ""(.*)""")]
        public void WhenIQueryForOpenPositionsAfter(string earliestPositionDate, string dataBaseName)
        {
            PositionsDataContext.DataBaseName = dataBaseName;
            PositionDataTableDictionary[dataBaseName] =
                PositionsDataContext.GetOpenPositionsFromDate(earliestPositionDate)
                    .ConvertToTypedDataTable<PositionDataTable>(dataBaseName, new[] {"Order"});
        }

        [Then(@"at least 1 position is returned for login ""(.*)"" on ""(.*)""")]
        public void ThenAtLeastPositionIsReturnedForLogin(int login, string dataBaseName)
        {
            PositionDataTableDictionary[dataBaseName].Rows.Cast<PositionDataRow>()
                .Should().Contain(r => r.Login == login);
            //.Contain(r => r.Login == login);
        }
    }
}