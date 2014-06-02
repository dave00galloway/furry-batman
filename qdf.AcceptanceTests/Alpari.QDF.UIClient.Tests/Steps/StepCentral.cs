using System.Configuration;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public const string REDIS_HOST = "redisHost";

        private RedisConnectionHelper _redisConnectionHelper;

        protected RedisConnectionHelper RedisConnectionHelper
        {
            get
            {
                return _redisConnectionHelper ??
                       (_redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings[REDIS_HOST]));
            }
        }

        protected QdfDataRetrievalStepBase QdfDataRetrievalStepBase
        {
            get
            {
                bool toAdd = GetStepDefinition(QdfDataRetrievalStepBase.FullName) == null;
                QdfDataRetrievalStepBase steps = (QdfDataRetrievalStepBase)
                    GetStepDefinition(QdfDataRetrievalStepBase.FullName) ??
                                                 new QdfDataRetrievalStepBase();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected QdfDataRetrievalSteps QdfDataRetrievalSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(QdfDataRetrievalSteps.FullName) == null;
                QdfDataRetrievalSteps steps = (QdfDataRetrievalSteps)
                    GetStepDefinition(QdfDataRetrievalSteps.FullName) ??
                                              new QdfDataRetrievalSteps();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        [AfterScenario]
        public void TearDown()
        {
            if (_redisConnectionHelper != null)
            {
                RedisConnectionHelper.Connection.Close(true);
            }
        }
    }
}
