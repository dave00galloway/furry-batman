using System;
using System.Collections.Generic;
using Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class TypedDataTableFunSteps
    {
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


        [Then(@"the person data should match exactly")]
        public void ThenThePersonDataShouldMatchExactly()
        {
            //this null check won't work - need to check each of the checks within diffs to see their values
            // ScenarioContext.Current["diffs"].Should().BeNull();
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];

            diffs.CheckForDifferences().Should().BeNullOrWhiteSpace();
        }

        [Then(@"the person data should contain (.*) ""(.*)""")]
        public void ThenThePersonDataShouldContain(int diffCount, string diffType)
        {
            var diffs = (DataTableComparison) ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().NotBeNullOrWhiteSpace();
            switch (diffType.ToLower())
            {
                case "mismatch":
                case "mismatches":
                case "field diffs":
                case "field diff":
                    diffs.FieldDifferences.Rows.Should().HaveCount(diffCount);
                    break;
                case "extra":
                    diffs.AdditionalInCompareWith.Should().HaveCount(diffCount);
                    break;
                case "missing":
                    diffs.MissingInCompareWith.Should().HaveCount(diffCount);
                    break;
                default:
                    throw new ArgumentException("diffType {0} not recognised", diffType);
            }
        }
    }
}