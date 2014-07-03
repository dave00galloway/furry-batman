using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.Tests.Steps;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps.SelfTest
{
    [Binding]
    public class LocalHostSteps
    {
        [Given(@"I am running a test on localhost")]
        public void GivenIAmRunningATestOnLocalhost()
        {
            StepCentral.UiClientTestsStepsStepCentral.RedisConnectionHelper.Connection.Host.Should()
                .Be("127.0.0.1");
        }

    }
}
