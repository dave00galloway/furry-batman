using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.X64.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public static readonly string FullName = typeof (StepCentral).FullName;
        public const string CC_CONNECTION_STRING = "CcConnectionString";
        public const string ARS_CONNECTION_STRING = "ArsConnectionString";
        public const string MT4_ARS_POSTIONS_CONTEXT = "Mt4ArsPositionsContext";
        public const string CC_DATA_CONTEXT = "CCDataContext";
        public const string CC_DATA_CONTEXT_POOL = "CCDataContextPool";
    }

}
    
