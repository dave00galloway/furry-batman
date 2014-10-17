//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using Alpari.QA.CC.MT4Positions2RedisTests.Steps;
//using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
//using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
//using TechTalk.SpecFlow;

//namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
//{
//    [Binding]
//    public class LogFileParserHooks : SpecFlowExtensionsHooks
//    {
//        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

//        [BeforeScenario]
//        public void BeforeScenario()
//        {
//            SetupObjectContainerAndTagsProperties();
//            SetupLogFileParserCheck();
//        }

//        private void SetupLogFileParserCheck()
//        {
//            if (TagDependentAction(StepCentral.MT4_ARS_POSTIONS_CONTEXT))
//            {
//                SetupLogFileParser();
//            }
//        }

//        public static ILogFileParser SetupLogFileParser()
//        {
//            ILogFileParser logFileParser;
//            try
//            {
//                logFileParser = ObjectContainer.Resolve<ILogFileParser>();
//            }
//            catch (Exception)
//            {
//                logFileParser = new LogFileParser();
//                ObjectContainer.RegisterInstanceAs(logFileParser);
//            }
//            return logFileParser;
//        }

//        //[AfterScenario]
//        //public void AfterScenario()
//        //{
//        //    //TODO: implement logic that has to run after executing each scenario
//        //}
//    }
//}
