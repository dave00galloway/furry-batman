using Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using FluentAssertions;

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
            var exp = PersonData.ConvertIEnumerableToDataTable(ScenarioContext.Current[first] as IEnumerable<Person>);
            var act = PersonData.ConvertIEnumerableToDataTable(ScenarioContext.Current[second] as IEnumerable<Person>);
            //var diffBase = exp.Copy();
           // diffBase.Merge(
            exp.Merge(act);
            var diffs = exp.GetChanges();
            //doesn't seem to undo the merge, even if the merge was done without preserving changes
            //exp.RejectChanges();
            //exp.AcceptChanges();
            //exp.
            ScenarioContext.Current["diffs"] = diffs;
        }


        [Then(@"the person data should match exactly")]
        public void ThenThePersonDataShouldMatchExactly()
        {
            ScenarioContext.Current["diffs"].Should().BeNull();
        }

    }
}
