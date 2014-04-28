using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionStepBase : StepCentral
    {
        public new static readonly string StepBaseRootNamspace = "Alpari.QualityAssurance.SpecFlowExtensions.Steps.";

        public CrossStepDefinitionStepBase()
            : base(true)
        {
        }
    }
}