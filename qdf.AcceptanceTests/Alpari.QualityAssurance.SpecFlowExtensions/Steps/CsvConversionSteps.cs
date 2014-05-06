using Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System.Collections.Generic;
using System.IO;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CsvConversionSteps : StepCentral
    {
        public static readonly string FullName = typeof(CsvConversionSteps).FullName;
        public CsvConversionSteps()
            : base(true)
        {
        }

        [When(@"I export the ""(.*)"" person data to csv ""(.*)""")]
        public void WhenIExportThePersonDataToCsv(string dataRef, string path)
        {
            File.Delete(path);
            WhenIAppendThePersonDataToCsv(dataRef,path);
        }


        [When(@"I import the csv file ""(.*)"" as a Person list caled ""(.*)""")]
        public void WhenIImportTheCsvFileAsAPersonListCaled(string path, string dataRef)
        {
            ScenarioContext.Current[dataRef] = path.CsvToList<Person>(",");
        }

        [When(@"I append the ""(.*)"" person data to csv ""(.*)""")]
        public void WhenIAppendThePersonDataToCsv(string dataRef, string path)
        {
            var people = ScenarioContext.Current[dataRef] as IEnumerable<Person>;
            people.EnumerableToCsv(path);
        }

    }
}
