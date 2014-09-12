using Alpari.QDF.UIClient.App;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class LuaScriptingSteps :StepCentral
    {
        public LuaScriptingSteps(RedisConnectionHelper redisConnectionHelper) : base(redisConnectionHelper)
        {
        }

        private string Script { get; set; }
        private object Result { get; set; }

        [Given(@"I have the following script ""(.*)"" to send to redis cli")]
        public void GivenIHaveTheFollowingScriptToSendToRedisCli(string script)
        {
            Script = script;
        }

        [Given(@"I have a valid deal query script")]
        public void GivenIHaveAValidDealQueryScript()
        {
            const string luaScript = "local tDecoded = cjson.decode(redis.call('GET', KEYS[1]));\n"
                                     + "local tFinal = {};\n"
                                     + "for iIndex, tValue in ipairs(tDecoded) do\n"
                                     + "     if tonumber( tValue.Server ) = 331 then\n"
                                     + "        table.insert(tFinal, { DealId = tValue.DealId, Server = tValue.Server});\n"
                                     //+ "     else\n"
                                     //+ "         table.insert(tFinal, { DealId = 999, Server = 0});\n"
                                     + "     end\n"
                                     + "end\n"
                                     + "return cjson.encode(tFinal);";
            Script = luaScript;
        }


        [When(@"I send the script to redis cli")]
        public async void WhenISendTheScriptToRedisCli()
        {
            Result = await RedisConnectionHelper.Connection.Scripting.Eval(0, Script, new string[] { }, new object[] { });
        }

        [When(@"I load the script to redis cli")]
        public async void WhenILoadTheScriptToRedisCli()
        {
            Result = await RedisConnectionHelper.Connection.Scripting.Eval(0, "SCRIPT LOAD " + Script, new string[] { }, new object[] { });
        }


        [Then(@"the result should be ""(.*)""")]
        public void ThenTheResultShouldBe(string expected)
        {
            Result.Should().Be(expected);
        }

    }
}
