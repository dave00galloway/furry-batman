using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT4;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QA.CC.MT4Positions2RedisTests.Steps.StepCentral;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class ArsPositionsHooks : SpecFlowExtensionsHooks
    {
        public ArsPositionsHooks(IDictionary<string, PositionDataTable> positionDataTableDictionary)
        {
            PositionDataTableDictionary = positionDataTableDictionary;
        }

        private IDictionary<string, PositionDataTable> PositionDataTableDictionary { get; set; }

        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
            SetupPositionsDataContext();
        }

        private void SetupPositionsDataContext()
        {
            if (TagDependentAction(StepCentral.MT4_ARS_POSTIONS_CONTEXT))
            {
                SetupPositionsContext();
            }
        }

        public static PositionsDataContext SetupPositionsContext()
        {
            string connectionString =// @"server=10.10.144.237;user id=ars;password=1q2w3e;port=3306";
                ConfigurationManager.ConnectionStrings[StepCentral.ARS_CONNECTION_STRING].ConnectionString;
            var context = new PositionsDataContext(connectionString);
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(context);
            return context;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            try
            {
                foreach (var positionDataTable in PositionDataTableDictionary)
                {
                    positionDataTable.Value.Rows.Cast<PositionDataRow>().OrderBy(p=>p.Login).ThenBy(p=>p.Order)
                        .EnumerableToCsv(
                            String.Format("{0}{1}.{2}", MasterStepBase.ScenarioOutputDirectory, positionDataTable.Key,
                                CsvParserExtensionMethods.csv), true,true,true,true);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            finally
            {
                ObjectContainer = null;
            }
            MoveExampleEvidence();
        }

        [BeforeFeature]
        public static void BeforeFeature()
        {
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }
    }
}