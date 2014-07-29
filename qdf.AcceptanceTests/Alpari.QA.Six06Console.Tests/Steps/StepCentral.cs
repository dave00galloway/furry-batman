using Alpari.QA.ProcessRunner.Tests.Steps;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
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
                var steps = (Six06ConsoleQdfDbSteps) GetStepDefinition(Six06ConsoleQdfDbSteps.FullName) ??
                                                              new Six06ConsoleQdfDbSteps(new GetTradesWithEventId());
                if (toAdd)
                {
                    _six06ConsoleQdfDbSteps = steps;
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        
    }
}