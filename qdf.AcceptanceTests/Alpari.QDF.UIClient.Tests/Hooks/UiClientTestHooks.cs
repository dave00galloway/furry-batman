using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Hooks
{
    [Binding]
    public class UiClientTestHooks : SpecFlowExtensionsHooks
    {
        public const string REDIS_HOST = "redisHost";
        private static RedisConnectionHelper _redisConnectionHelper;

        [BeforeScenario]
        public void Setup()
        {
            SetupObjectContainerAndTagsProperties();
            SetupRedisConnectionHelper();
        }

        public static RedisConnectionHelper SetupRedisConnectionHelper()
        {
            if (_redisConnectionHelper != null) return _redisConnectionHelper;
            _redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]);
            ObjectContainer.RegisterInstanceAs(_redisConnectionHelper);
            return _redisConnectionHelper;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            try
            {
                if (_redisConnectionHelper == null) return;
                _redisConnectionHelper.Connection.Close(true);
                _redisConnectionHelper.Connection.Dispose();
                _redisConnectionHelper = null;
                GC.Collect();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            finally
            {
                ObjectContainer = null;
            }
        }
    }
}
