using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    }
}
