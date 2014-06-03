using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.ControlHelpers;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class SetupUiControlsSteps : SetupUiControlsStepBase
    {
        new public static readonly string FullName = typeof(SetupUiControlsSteps).FullName;
        

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

    }
}
