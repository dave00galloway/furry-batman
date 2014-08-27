using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QDF.ConversionRateData.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QDF.ConversionRateData.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public static ConversionRateDataSteps ConversionRateDataSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(ConversionRateDataSteps.FullName) == null;
                var steps = (ConversionRateDataSteps)
                    GetStepDefinition(ConversionRateDataSteps.FullName) ??
                                                  new ConversionRateDataSteps(WebClientHooks.SetupCurrenexHubAdminWebClient());
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }        
    }
}
