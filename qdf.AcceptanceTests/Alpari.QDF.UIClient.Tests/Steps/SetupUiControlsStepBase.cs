using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.ControlHelpers;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class SetupUiControlsStepBase : StepCentral
    {
        public static readonly string FullName = typeof(SetupUiControlsStepBase).FullName;
        protected TradingServerControl TradingServerControl { get; set; }
        protected BookControl BookControl { get; set; }
        protected SymbolControl SymbolControl { get; set; }
        protected EnvironmentControl EnvironmentControl { get; set; }
        protected Exporter Exporter { get; private set; }

        public SetupUiControlsStepBase()
        {  
            //I have no idea how the OutputToCsvSteps and base manage to create an exporter through DI, since how is the default host passed to the RedisConnectionHelper?
            Exporter = new Exporter(RedisConnectionHelper);
           

            // RedisConnectionHelper redisConnectionHelper = RedisConnectionHelper;
        }
    }
}
