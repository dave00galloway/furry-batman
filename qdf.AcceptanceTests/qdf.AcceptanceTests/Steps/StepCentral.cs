using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Steps
{
    public class StepCentral : MasterStepBase
    {
        protected static DealReconciliationStepBase DealReconciliationStepBase
        {
            get
            {
                return (DealReconciliationStepBase) GetStepDefinition(DealReconciliationStepBase.FullName) ??
                       new DealReconciliationStepBase();
            }
        }

        protected static DealReconciliationSteps DealReconciliationSteps
        {
            get
            {
                return (DealReconciliationSteps)GetStepDefinition(DealReconciliationSteps.FullName) ??
                       new DealReconciliationSteps();
            }
        }

        public static QdfAnalysisOfArsCcEcnDiffDeltasStepBase QdfAnalysisOfArsCcEcnDiffDeltasStepBase
        {
            get
            {
                return
                    (QdfAnalysisOfArsCcEcnDiffDeltasStepBase)
                        GetStepDefinition(QdfAnalysisOfArsCcEcnDiffDeltasStepBase.FullName) ??
                    new QdfAnalysisOfArsCcEcnDiffDeltasStepBase();
            }
        }

        public static QdfAnalysisOfArsCcEcnDiffDeltasSteps QdfAnalysisOfArsCcEcnDiffDeltasSteps
        {
            get
            {
                return
                    (QdfAnalysisOfArsCcEcnDiffDeltasSteps)
                        GetStepDefinition(QdfAnalysisOfArsCcEcnDiffDeltasSteps.FullName) ??
                    new QdfAnalysisOfArsCcEcnDiffDeltasSteps(new SignalsCompareData());
            }
        }
    }
}
