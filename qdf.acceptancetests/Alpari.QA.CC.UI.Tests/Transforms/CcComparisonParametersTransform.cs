using System.Collections.Generic;
using System.Linq;
using Alpari.QA.CC.UI.Tests.POCO;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.UI.Tests.Transforms
{
    [Binding]
    public class CcComparisonParametersTransform
    {
        [StepArgumentTransformation]
        public static CcComparisonParameters LogFileParserParametersTransform(Table table)
        {
            return table.CreateInstance<CcComparisonParameters>();
        }

        [StepArgumentTransformation]
        public static IList<CcComparisonParameters> LogFileParserParametersSetTransform(Table table)
        {
            return table.CreateSet<CcComparisonParameters>().ToList();
        }
    }
}