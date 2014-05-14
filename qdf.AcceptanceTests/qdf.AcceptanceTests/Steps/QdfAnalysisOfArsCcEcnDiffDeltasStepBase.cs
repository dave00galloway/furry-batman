using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasStepBase :StepCentral
    {

        public static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasStepBase).FullName;
        protected SignalsCompareDataDataContext SignalsCompareDataDataContext { get; private set; }
        protected DiffDeltaParameters DiffDeltaParameters { get; set; }
        protected DiffDeltaFinder DiffDeltaFinder { get; set; }    

        public QdfAnalysisOfArsCcEcnDiffDeltasStepBase(SignalsCompareData signalsCompareData, DiffDeltaFinder diffDeltaFinder)
        {
            DiffDeltaFinder = diffDeltaFinder;
            SignalsCompareDataDataContext = signalsCompareData.SignalsCompareDataDataContext;
        }

        [StepArgumentTransformation]
        public static DiffDeltaParameters DiffDeltaParametersTransform(Table table)
        {
            return table.CreateInstance<DiffDeltaParameters>();
        }
    }
}
