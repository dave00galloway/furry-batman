using System;
using System.Collections.Generic;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class Mt4CompositeApiHooks : SpecFlowExtensionsHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            SetupMt4CompositeApi();
        }

        public static IMt4CompositeApi SetupMt4CompositeApi()
        {
            IMt4CompositeApi api;
            try
            {
                api = ObjectContainer.Resolve<IMt4CompositeApi>();
            }
            catch (Exception)
            {
                api = new Mt4CompositeApi(new Dictionary<string, Mt4TradeLoadResult>());
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(api);
            }
            return api;
        }

        //[AfterScenario]
        //public void AfterScenario()
        //{
        //    //TODO: implement logic that has to run after executing each scenario
        //}
    }
}