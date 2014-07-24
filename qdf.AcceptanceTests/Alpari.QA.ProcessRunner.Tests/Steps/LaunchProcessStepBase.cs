using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class LaunchProcessStepBase : StepCentral
    {
        public new static readonly string FullName = typeof (LaunchProcessStepBase).FullName;

        private IProcessRunner _processRunner;
        private IProcessStartInfoWrapper _processStartInfoWrapper;

        public IProcessStartInfoWrapper ProcessStartInfoWrapper
        {
            get { return _processStartInfoWrapper; }
            set
            {
                _processStartInfoWrapper = value;
                ScenarioContext.Current.Add(PROCESS_START_INFO_WRAPPER, _processStartInfoWrapper);
            }
        }

        public IProcessRunner ProcessRunner
        {
            get { return _processRunner; }
            set
            {
                _processRunner = value;
                ScenarioContext.Current.Add(PROCESS_RUNNER, _processRunner);
            }
        }

        [StepArgumentTransformation]
        public static ProcessStartInfoWrapper IncludedLoginsTransform(Table table)
        {
            return table.CreateInstance<ProcessStartInfoWrapper>();
        }
    }
}