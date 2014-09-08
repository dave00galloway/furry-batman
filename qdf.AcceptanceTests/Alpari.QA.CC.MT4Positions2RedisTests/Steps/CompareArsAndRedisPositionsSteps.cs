using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT4;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class CompareArsAndRedisPositionsSteps : StepCentral
    {
        public new static readonly string FullName = typeof(CompareArsAndRedisPositionsSteps).FullName;

        public CompareArsAndRedisPositionsSteps(
            IDictionary<string, PositionDataTable> positionDataTableDictionary)
        {
            PositionDataTableDictionary = positionDataTableDictionary;
        }

        public IDictionary<string, PositionDataTable> PositionDataTableDictionary { get; set; }

        [When(@"I compare the ""(.*)"" positions with the ""(.*)"" positions excluding these fields:")]
        public void GivenICompareThePositionsWithThePositionsExcludingTheseFields(string redisPositionName, string arsPositionName, Table table)
        {
            DataTableComparison diffs =
                PositionDataTableDictionary[redisPositionName].Compare(PositionDataTableDictionary[arsPositionName],table.IgnoredFieldsQuery(),null,false,true); //  CompareCnxHubAdminDealsWithQdfCnxDeals(table);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [Then(@"the redis positions should match the ars positions exactly:-")]
        public void ThenTheRedisPositionsShouldMatchTheArsPositionsExactly_(ExportParameters exportParameters)
        {
            DataTableComparison.CheckComparisonInScenarioContext(exportParameters,ScenarioOutputDirectory);
        }

        /// <summary>
        /// TODO:- rename to ExportParametersTransform and move to MasterStepBase?
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        [StepArgumentTransformation]
        public static ExportParameters QuoteSearchParametersTransform(Table table)
        {
            var parameters = table.CreateInstance<ExportParameters>();
            if (parameters.ExportType == ExportTypes.Csv || parameters.ExportType == ExportTypes.DataTableToCsv)
            {
                parameters.Path = ScenarioOutputDirectory;
            }
            return parameters;
        }

    }
}
