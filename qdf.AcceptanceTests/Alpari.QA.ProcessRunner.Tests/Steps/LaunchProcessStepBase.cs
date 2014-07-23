using TechTalk.SpecFlow;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class LaunchProcessStepBase : StepCentral
    {
        public new static readonly string FullName = typeof (LaunchProcessStepBase).FullName;
    }
}