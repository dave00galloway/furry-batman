using System;
using System.Collections.Generic;
using Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class TypedDataTableFunSteps : StepCentral
    {
        public static readonly string FullName = typeof(TypedDataTableFunSteps).FullName;
        public TypedDataTableFunSteps()
            : base(true)
        {
        }

        [Given(@"I have the following person data:")]
        public void GivenIHaveTheFollowingPersonData(Table table)
        {
            ScenarioContext.Current.Pending();
        }

        [Given(@"I have the following ""(.*)"" person data:")]
        public void GivenIHaveTheFollowingPersonData(string dataName, IEnumerable<Person> persons)
        {
            ScenarioContext.Current[dataName] = persons;
        }

        [StepArgumentTransformation]
        public static IEnumerable<Person> PersonTransform(Table table)
        {
            return table.CreateSet<Person>();
        }


        [When(@"I compare the person data")]
        public void WhenICompareThePersonData()
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I compare the ""(.*)"" and ""(.*)"" person data")]
        public void WhenICompareTheAndPersonData(string first, string second)
        {
            var keys = new[] {"ID", "Lastname"};
            PersonData exp =
                new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[first] as IEnumerable<Person>,
                    "expected", keys);
            PersonData act =
                new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[second] as IEnumerable<Person>,
                    "actual", keys);
            DataTableComparison diffs = exp.Compare(act);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [When(@"I compare the ""(.*)"" and ""(.*)"" person data matching on id")]
        public void WhenICompareTheAndPersonDataMatchingOnId(string first, string second)
        {
            var keys = new[] { "ID", "Lastname" };
            PersonData exp =
                new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[first] as IEnumerable<Person>,
                    "expected", keys);
            PersonData act =
                new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[second] as IEnumerable<Person>,
                    "actual", new[] { "ID"});
            DataTableComparison diffs = exp.Compare(act);
            ScenarioContext.Current["diffs"] = diffs;
        }



        [Then(@"the person data should match exactly")]
        public void ThenThePersonDataShouldMatchExactly()
        {
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().BeNullOrWhiteSpace();
        }

        [Then(@"the person data should match exactly:-")]
        public void ThenThePersonDataShouldMatchExactly(ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences(exportParameters,true);
        }


        [Then(@"the person data should contain (.*) ""(.*)""")]
        public void ThenThePersonDataShouldContain(int diffCount, string diffType)
        {
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];
            //QueryDifferences(diffCount, diffType, diffs);
            diffs.QueryDifferences(diffCount,diffType);
        }

        [Then(@"the person data should contain (.*) ""(.*)"" :-")]
        public void ThenThePersonDataShouldContain(int diffCount, string diffType, ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            //diffs.CheckForDifferences(exportParameters);
            diffs.QueryDifferences(diffCount, diffType, exportParameters);
        }

        [StepArgumentTransformation]
        public static ExportParameters QuoteSearchParametersTransform(Table table)
        {
            return table.CreateInstance<ExportParameters>();
        }
        
    }
}