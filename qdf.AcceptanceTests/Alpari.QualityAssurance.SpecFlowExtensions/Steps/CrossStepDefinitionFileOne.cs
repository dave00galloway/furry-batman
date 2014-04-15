using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionFileOne : CrossStepDefinitionFileOneStepBase
    {
        [Given(@"I have called a method which sets a lazy property in step definition file one")]
        public void GivenIHaveCalledAMethodWhichSetsALazyPropertyInStepDefinitionFileOne()
        {
            LazyProperty = Context.TestRunContext.GenerateRandomStringFromFileName();
        }

        public string SetLazyProperty
        {
            set
            {
                LazyProperty = value;
            }
        }

    }
}
