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

        public SetupUiControlsStepBase()
        {
            
           // RedisConnectionHelper redisConnectionHelper = RedisConnectionHelper;
        }
    }
}
