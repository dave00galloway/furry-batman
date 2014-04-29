using System.Collections.Generic;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class CombinedTextAndXmlResult
    {
        public CombinedTextAndXmlResult(TestCaseTextResult textResult,
            ICollection<IDictionary<string, object>> testCasesByTestSuiteAsList)
        {
            TextResult = textResult;
            foreach (var item in from item in testCasesByTestSuiteAsList
                let taglist = item["Tags"].ToString()
                where taglist.Contains(TextResult.PrimaryTag)
                select item)
            {
                XmlResult = DataTableOperations.ConvertIDictionaryToDictionary(item);
                testCasesByTestSuiteAsList.Remove(XmlResult);
                // assumes that the promary tag really is unique across all tests. Removing from source list isn't (easily) possible in LINQ
                break;
            }
        }

        public TestCaseTextResult TextResult { get; set; }
        public Dictionary<string, object> XmlResult { get; set; } // new Dictionary<string, object>();
    }
}