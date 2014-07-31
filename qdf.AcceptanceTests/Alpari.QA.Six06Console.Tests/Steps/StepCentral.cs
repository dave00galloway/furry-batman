using System.Collections.Generic;
using System.Linq;
using Alpari.QA.ProcessRunner.Tests.Steps;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QA.Six06Console.Tests.DomainObjects;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        //TODO:- add const to config
        protected const string CONSOLE_IDLE_MESSAGE = "waiting 2 seconds..";
        protected const string ORDER_EVENT_ID_DELIMITER = ">";
        protected const string ORDER_IDENTIFIER = "#";
        protected const char ORDER_DEAL_DELIMITER = '(';
        protected const string ORDER_DEAL_TERMINATOR = ")";
        public const string FRESH606_POINT5_CONSOLE_CONFIG_CONSOLE_INI = @"AUT\QDF\606.5Console\Config\606.5Console.ini";
        public const string WORKING606_POINT5_CONSOLE_INI = @"AUT\QDF\606.5Console\606.5Console.ini";
        public const string MT5_DEALS_CONTEXT = "Mt5DealsContext";
        public const string MT5_DB = "MT5DB";

        public static readonly string FullName = typeof (StepCentral).FullName;
        private static ProcessRunner.Tests.Steps.StepCentral _processRunnerStepCentral;
        private Six06ConsoleAppSteps _six06ConsoleAppSteps;
        private Six06ConsoleQdfDbSteps _six06ConsoleQdfDbSteps;


        private static ProcessRunner.Tests.Steps.StepCentral ProcessRunnerStepCentral
        {
            get
            {
                if (_processRunnerStepCentral != null)
                {
                    return _processRunnerStepCentral;
                }
                bool toAdd = GetStepDefinition(ProcessRunner.Tests.Steps.StepCentral.FullName) == null;
                ProcessRunner.Tests.Steps.StepCentral steps = (ProcessRunner.Tests.Steps.StepCentral)
                    GetStepDefinition(ProcessRunner.Tests.Steps.StepCentral.FullName) ??
                                                              new ProcessRunner.Tests.Steps.StepCentral();
                if (toAdd)
                {
                    _processRunnerStepCentral = steps;
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected LaunchProcessSteps LaunchProcessSteps
        {
            get { return ProcessRunnerStepCentral.LaunchProcessSteps; }
        }

        public Six06ConsoleQdfDbSteps Six06ConsoleQdfDbSteps
        {
            get
            {
                if (_six06ConsoleQdfDbSteps != null)
                {
                    return _six06ConsoleQdfDbSteps;
                }
                bool toAdd = GetStepDefinition(Six06ConsoleQdfDbSteps.FullName) == null;
                Six06ConsoleQdfDbSteps steps =
                    (Six06ConsoleQdfDbSteps) GetStepDefinition(Six06ConsoleQdfDbSteps.FullName) ??
                    new Six06ConsoleQdfDbSteps(new GetTradesWithEventId());
                if (toAdd)
                {
                    _six06ConsoleQdfDbSteps = steps;
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        public Six06ConsoleAppSteps Six06ConsoleAppSteps
        {
            get
            {
                if (_six06ConsoleQdfDbSteps != null)
                {
                    return _six06ConsoleAppSteps;
                }
                bool toAdd = GetStepDefinition(Six06ConsoleAppSteps.FullName) == null;
                Six06ConsoleAppSteps steps = (Six06ConsoleAppSteps) GetStepDefinition(Six06ConsoleAppSteps.FullName) ??
                                             new Six06ConsoleAppSteps();
                if (toAdd)
                {
                    _six06ConsoleAppSteps = steps;
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected static void CheckDealsHaveBeenMappedToOrderEventIds(
            IDictionary<int, OrderDealMapping> orderEventIdToDealMapping,
            TradeWithEventIdWithDealAndOrderDataTable tradeWithEventIdWithDealAndOrderDataTable)
        {
            List<ulong> orders = orderEventIdToDealMapping.Values.Select(x => (ulong) x.Order).ToList();
            List<ulong> deals = orderEventIdToDealMapping.Values.Select(x => (ulong) x.Deal).ToList();
            List<ulong> ordersToCheck =
                tradeWithEventIdWithDealAndOrderDataTable.Rows.Cast<TradeWithEventIdWithDealAndOrderDataTableRow>()
                    .Select(x => x.Order)
                    .ToList();
            List<ulong> dealsToCheck =
                tradeWithEventIdWithDealAndOrderDataTable.Rows.Cast<TradeWithEventIdWithDealAndOrderDataTableRow>()
                    .Select(x => x.Deal)
                    .ToList();
            List<int> orderEventIdsToCheck =
                tradeWithEventIdWithDealAndOrderDataTable.Rows.Cast<TradeWithEventIdWithDealAndOrderDataTableRow>()
                    .Select(x => x.OrderEventId)
                    .ToList();
            orders.Should().BeEquivalentTo(ordersToCheck);
            ordersToCheck.Should().BeEquivalentTo(orders);
            deals.Should().BeEquivalentTo(dealsToCheck);
            dealsToCheck.Should().BeEquivalentTo(deals);
            orderEventIdToDealMapping.Keys.Should().BeEquivalentTo(orderEventIdsToCheck);
            orderEventIdsToCheck.Should().BeEquivalentTo(orderEventIdToDealMapping.Keys);
        }
    }
}