using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionStepBase : StepCentral
    {
        public CrossStepDefinitionStepBase()
            : base(true)
        {

        }
        new public static readonly string STEP_BASE_ROOT_NAMSPACE = "Alpari.QualityAssurance.SpecFlowExtensions.Steps.";
    }
}
