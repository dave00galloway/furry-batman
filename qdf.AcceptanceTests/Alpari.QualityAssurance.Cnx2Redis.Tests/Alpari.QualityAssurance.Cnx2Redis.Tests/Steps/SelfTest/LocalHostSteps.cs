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
            QDF.UIClient.Tests.Steps.StepCentral.RedisConnectionHelper.Connection.Host.Should().Be("127.0.0.1");
        }

    }
}
