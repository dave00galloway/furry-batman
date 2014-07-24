using System.Globalization;
using Alpari.QA.Six06Console.Tests.DomainObjects;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleAppSteps : Six06ConsoleAppStepBase
    {
        public new static readonly string FullName = typeof (Six06ConsoleAppSteps).FullName;


        [When(@"I parse the order events from the console into orders and deals")]
        public void WhenIParseTheOrderEventsFromTheConsoleIntoOrdersAndDeals()
        {
            //synchoronise on completed sql. throw error if not able to start or if there are no deals to pull
            LaunchProcessSteps.ThenTheStandardErrorOutputContainsText(ORDER_EVENT_ID_DELIMITER);
            LaunchProcessSteps.ThenTheStandardErrorOutputContainsText(CONSOLE_IDLE_MESSAGE);
            ParseStandardErrorOutputToOrderDealMapping();
        }


    }
}