using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public const string PROCESS_START_INFO_WRAPPER = "ProcessStartInfoWrapper";
        public const string PROCESS_RUNNER = "ProcessRunner";
        public static readonly string FullName = typeof (StepCentral).FullName;
    }
}