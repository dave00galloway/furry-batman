using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public static readonly string FullName = typeof(StepCentral).FullName;
        public const string CC_CONNECTION_STRING = "CcConnectionString";
        public const string ARS_CONNECTION_STRING = "ArsConnectionString";
        public const string MT4_ARS_POSTIONS_CONTEXT = "Mt4ArsPositionsContext";
        public const string CC_DATA_CONTEXT = "CCDataContext";
        public const string CC_DATA_CONTEXT_POOL = "CCDataContextPool";

        public static Mt4TradeExeSteps Mt4TradeExeSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(Mt4TradeExeSteps.FullName) == null;
                Mt4TradeExeSteps steps = (Mt4TradeExeSteps)
                    GetStepDefinition(Mt4TradeExeSteps.FullName) ??
                                         new Mt4TradeExeSteps();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        public static Mt4DotNetManagerWrapperSteps Mt4DotNetManagerWrapperSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(Mt4DotNetManagerWrapperSteps.FullName) == null;
                Mt4DotNetManagerWrapperSteps steps = (Mt4DotNetManagerWrapperSteps)
                    GetStepDefinition(Steps.Mt4DotNetManagerWrapperSteps.FullName) ??
                                         new Mt4DotNetManagerWrapperSteps();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        public static CompareArsAndRedisPositionsSteps CompareArsAndRedisPositionsSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(CompareArsAndRedisPositionsSteps.FullName) == null;
                CompareArsAndRedisPositionsSteps steps = (CompareArsAndRedisPositionsSteps)
                    GetStepDefinition(Steps.CompareArsAndRedisPositionsSteps.FullName) ??
                                         new CompareArsAndRedisPositionsSteps(new Dictionary<string, PositionDataTable>());
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }            
        }

        public static GetRedisPositionsSteps GetRedisPositionsSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(GetRedisPositionsSteps.FullName) == null;
                Dictionary<string, PositionDataTable> dict = null;
                if (toAdd)
                {
                    try
                    {
                        dict = ObjectContainer.Resolve<Dictionary<string, PositionDataTable>>();
                    }
                    catch (Exception)
                    {
                        dict = new Dictionary<string, PositionDataTable>();
                        ObjectContainer.RegisterInstanceAs(dict);
                    }
                }
                GetRedisPositionsSteps steps = (GetRedisPositionsSteps)
                    GetStepDefinition(Steps.GetRedisPositionsSteps.FullName) ??
                                         new GetRedisPositionsSteps(dict);
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }
    }
}
