﻿using System;
using System.Collections.Concurrent;
using System.Configuration;
using Alpari.QA.CC.MT4Positions2RedisTests.Steps;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using Alpari.QualityAssurance.SecureMyPassword;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class CapitalCalculationSnapshotHooks : SpecFlowExtensionsHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            if (TagDependentAction(StepCentral.CC_DATA_CONTEXT))
            {
                SetupCapitalCalculationDataContext();
            }
            if (TagDependentAction(StepCentral.CC_DATA_CONTEXT_POOL))
            {
                SetupCapitalCalculationDataContextPool();
            }
        }

        private static CapitalCalculationDataContextPool SetupCapitalCalculationDataContextPool()
        {
            CapitalCalculationDataContextPool ccDataConnectionPool;
            try
            {
                ccDataConnectionPool = ObjectContainer.Resolve<CapitalCalculationDataContextPool>();
            }
            catch (Exception)
            {
                ccDataConnectionPool = new CapitalCalculationDataContextPool(new ConcurrentDictionary<string, CapitalCalculationDataContext>());
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(ccDataConnectionPool);
            }
            return ccDataConnectionPool;
        }

        public static CapitalCalculationDataContext SetupCapitalCalculationDataContext()
        {
            CapitalCalculationDataContext ccDataContext;
            try
            {
                ccDataContext = ObjectContainer.Resolve<CapitalCalculationDataContext>();
            }
            catch (Exception)
            {
                ccDataContext =
                    new CapitalCalculationDataContext(
                        ConfigurationManager.ConnectionStrings[StepCentral.CC_CONNECTION_STRING].ConnectionString
                            .UnProtect('_'));
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(ccDataContext);
            }
            return ccDataContext;
        }
    }
}