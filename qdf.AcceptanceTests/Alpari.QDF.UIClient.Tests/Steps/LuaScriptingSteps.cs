using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class LuaScriptingSteps :StepCentral
    {
        private string Script { get; set; }
        private object Result { get; set; }

        [Given(@"I have the following script ""(.*)"" to send to redis cli")]
        public void GivenIHaveTheFollowingScriptToSendToRedisCli(string script)
        {
            Script = script;
        }

        [When(@"I send the script to redis cli")]
        public async void WhenISendTheScriptToRedisCli()
        {
            Result = await RedisConnectionHelper.Connection.Scripting.Eval(0, Script, new string[] { }, new object[] { });
        }

        [Then(@"the result should be ""(.*)""")]
        public void ThenTheResultShouldBe(string expected)
        {
            Result.Should().Be(expected);
        }

    }
}
