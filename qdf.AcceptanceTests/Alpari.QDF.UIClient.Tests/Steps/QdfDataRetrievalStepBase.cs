using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfDataRetrievalStepBase : StepCentral
    {

        public static readonly string FullName = typeof(QdfDataRetrievalStepBase).FullName;
        

        [StepArgumentTransformation]
        public static DealSearchCriteria DiffDeltaParametersTransform(Table table)
        {
            return table.CreateInstance<DealSearchCriteria>();
        }


    }
}
