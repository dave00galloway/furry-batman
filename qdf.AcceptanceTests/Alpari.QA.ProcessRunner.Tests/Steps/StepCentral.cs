using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public static readonly string FullName = typeof (StepCentral).FullName;
        public const string PROCESS_START_INFO_WRAPPER = "ProcessStartInfoWrapper";
        public const string PROCESS_RUNNER = "ProcessRunner";

        //public static LaunchProcessSteps LaunchProcessSteps
        //{
        //    get
        //    {
        //        var toAdd = GetStepDefinition(LaunchProcessSteps.FullName) == null;
        //        _launchProcessSteps = (LaunchProcessSteps)
        //            GetStepDefinition(LaunchProcessSteps.FullName) ??
        //                                   new LaunchProcessSteps();
        //        if (toAdd)
        //        {
        //            ObjectContainer.RegisterInstanceAs(_launchProcessSteps);
        //        }
        //        return _launchProcessSteps;
        //    }
        //    set
        //    {
        //        _launchProcessSteps = value;
        //    }
        //}

        //private static LaunchProcessSteps _launchProcessSteps;
    }
}