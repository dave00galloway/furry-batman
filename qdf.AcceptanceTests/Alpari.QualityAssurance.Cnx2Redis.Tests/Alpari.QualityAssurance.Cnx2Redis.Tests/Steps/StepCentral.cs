using Alpari.QDF.UIClient.Tests.Steps;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public StepCentral(CnxTradeTableDataContext cnxTradeTableDataContext)
        {
            CnxTradeTableDataContext = cnxTradeTableDataContext;
        }

        protected CnxTradeTableDataContext CnxTradeTableDataContext { get; private set; }

        internal static QDF.UIClient.Tests.Steps.StepCentral UiClientTestsStepsStepCentral
        {
            get
            {
                bool toAdd = GetStepDefinition(QDF.UIClient.Tests.Steps.StepCentral.FullName) == null;
                QDF.UIClient.Tests.Steps.StepCentral steps = (QDF.UIClient.Tests.Steps.StepCentral)
                    GetStepDefinition(QDF.UIClient.Tests.Steps.StepCentral.FullName) ??
                                                             new QDF.UIClient.Tests.Steps.StepCentral();
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected static QdfDataRetrievalSteps QdfDataRetrievalSteps
        {
            get { return UiClientTestsStepsStepCentral.QdfDataRetrievalSteps; }
        }
    }
}