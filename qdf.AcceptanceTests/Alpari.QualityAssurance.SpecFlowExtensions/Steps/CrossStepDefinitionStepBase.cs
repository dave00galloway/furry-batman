using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionStepBase : StepCentral
    {
        

        public CrossStepDefinitionStepBase()
            : base(true)
        {
        }

        public static readonly string FullName = typeof(MasterStepBase).FullName;
    }
}