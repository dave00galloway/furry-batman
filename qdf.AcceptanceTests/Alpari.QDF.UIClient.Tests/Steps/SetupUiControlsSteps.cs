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

        [Then(@"the list of server options should be:")]
        public void ThenTheListOfServerOptionsShouldBe(Table table)
        {
            //foreach (TableRow tableRow in table.Rows)
            //{
            //    TradingServerControl.ServerList.Should().Contain(tableRow[SERVER_TABLE_KEY]);
            //}

            //foreach (string server in TradingServerControl.ServerList)
            //{
            //    table.Rows.Should().Contain(server);
            //}
            //var expectedServers = table.Rows.Where(x => x[SERVER_TABLE_KEY]).ToList();
            var expectedServers = (from row in table.Rows
                from col in row
                where col.Key == SERVER_TABLE_KEY
                select col.Value).ToList();
            TradingServerControl.ServerList.Should().BeEquivalentTo(expectedServers);
        }

    }
}
