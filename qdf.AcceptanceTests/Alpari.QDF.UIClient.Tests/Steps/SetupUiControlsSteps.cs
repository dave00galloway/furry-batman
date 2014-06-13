using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QualityAssurance.RefData;
using FluentAssertions;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class SetupUiControlsSteps : SetupUiControlsStepBase
    {
        new public static readonly string FullName = typeof(SetupUiControlsSteps).FullName;


        //public SetupUiControlsSteps(Exporter exporter) : base(exporter)
        //{
        //}

        [Given(@"I filter deals by server")]
        public void GivenIFilterDealsByServer()
        {
            TradingServerControl = new TradingServerControl();
        }

        [Given(@"I filter deals by book")]
        public void GivenIFilterDealsByBook()
        {
            BookControl = new BookControl();
        }

        [Given(@"I filter deals by symbol")]
        public void GivenIFilterDealsBySymbol()
        {
            SymbolControl = new SymbolControl();
        }

        [Given(@"I want to be able to switch environments")]
        public void GivenIWantToBeAbleToSwitchEnvironments()
        {
            EnvironmentControl = new EnvironmentControl(ReferenceData.Instance);
        }

        [Given(@"I choose the type of data to be queried")]
        public void GivenIChooseTheTypeOfDataToBeQueried()
        {
            SupportedDataTypesControl = new SupportedDataTypesControl();
        }

        [Then(@"the list of data type options should be:")]
        public void ThenTheListOfDataTypeOptionsShouldBe(Table table)
        {
            var expectedTypes = (from row in table.Rows
                from col in row
                where col.Key == DATATYPE_TABLE_KEY
                select col.Value).ToList();
            SupportedDataTypesControl.Types.ShouldBeEquivalentTo(expectedTypes);
        }


        [Then(@"I am connected to qdf on ""(.*)""")]
        [Given(@"I am connected to qdf on ""(.*)""")]
        public void GivenIAmConnectedToQdfOn(string environment)
        {
            Exporter.RedisConnectionHelper.RedisHost.Should().Be(environment);
        }

        [When(@"I change the redis connection to ""(.*)""")]
        public void WhenIChangeTheRedisConnectionTo(string environment)
        {
            Exporter.SwitchRedisConnection(environment);
        }

        [Then(@"the list of environments options should be:")]
        public void ThenTheListOfEnvironmentsOptionsShouldBe(Table table)
        {
            var expectedEnvironmnets = (from row in table.Rows
                from col in row
                where col.Key == ENVIRONMENT_TABLE_KEY
                select col.Value).ToList();
            var actualEnvironments = EnvironmentControl.EnvironmentListItems.Select(x => x.Key).ToList();
            actualEnvironments.ShouldBeEquivalentTo(expectedEnvironmnets);
        }


        [Then(@"the list of symbol options should be:")]
        public void ThenTheListOfSymbolOptionsShouldBe(Table table)
        {
            var expectedSymbols = (from row in table.Rows
                from col in row
                where col.Key == SYMBOL_TABLE_KEY
                select col.Value).ToList();
            var actualSymbols = SymbolControl.SymbolListItems.Select(x=>x.Symbol).ToList();
            actualSymbols.ShouldBeEquivalentTo(expectedSymbols);
        }


        [Then(@"the list of book options should be:")]
        public void ThenTheListOfBookOptionsShouldBe(Table table)
        {
            var expectedBooks = (from row in table.Rows
                from col in row
                where col.Key == BOOK_TABLE_KEY
                select col.Value).ToList();
            BookControl.BookList.Should().BeEquivalentTo(expectedBooks);
        }


        [Then(@"the list of server options should be:")]
        public void ThenTheListOfServerOptionsShouldBe(Table table)
        {
            var expectedServers = (from row in table.Rows
                from col in row
                where col.Key == SERVER_TABLE_KEY
                select col.Value).ToList();
            TradingServerControl.ServerList.Should().BeEquivalentTo(expectedServers);
        }

        [Then(@"the default value set in the environment control is ""(.*)""")]
        public void ThenTheDefaultValueSetInTheEnvironmentControlIs(string environment)
        {
            EnvironmentControl.GetInitialValue(Exporter.RedisConnectionHelper.RedisHost).Should().Be(environment);
        }

        [Then(@"the default datatype should be ""(.*)""")]
        public void ThenTheDefaultDatatypeShouldBe(string datatype)
        {
            SupportedDataTypesControl.Default.Should().Be(datatype);
        }


    }
}
