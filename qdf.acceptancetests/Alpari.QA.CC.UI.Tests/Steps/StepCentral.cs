using System.Collections.Generic;
using System.Linq;
using Alpari.QA.CC.UI.Tests.BusinessProcesses;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        [StepArgumentTransformation]
        public new static ExportParameters ExportParametersTransform(Table table)
        {
            return MasterStepBase.ExportParametersTransform(table);
        }

        [StepArgumentTransformation]
        public new static IEnumerable<ExportParameters> ExportParametersSetTransform(Table table)
        {
            return MasterStepBase.ExportParametersSetTransform(table);
        }


    }
}