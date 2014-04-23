using Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using FluentAssertions;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

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
            var keys = new string[] { "ID", "Lastname" };
            var exp = new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[first] as IEnumerable<Person>,"expected",keys);
            var act = new PersonData().ConvertIEnumerableToDataTable(ScenarioContext.Current[second] as IEnumerable<Person>,"actual",keys);
            var diffs = exp.Compare(act);
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
    }
}
