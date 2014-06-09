using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfQuoteQueryStepBase : StepCentral
    {
        public static readonly string FullName = typeof(QdfQuoteQueryStepBase).FullName;
    }
}
