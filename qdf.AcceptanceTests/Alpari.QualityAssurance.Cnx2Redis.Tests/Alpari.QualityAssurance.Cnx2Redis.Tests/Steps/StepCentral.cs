using System.Linq;
using Alpari.QDF.UIClient.Tests.Steps;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public static readonly string FullName = typeof (StepCentral).FullName;

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

        /// <summary>
        ///     return the current instance of CnxHubAdminSteps, or create a new one. note, the dependencies for CnxHubAdminSteps
        ///     (currently CnxTradeTableDataContext and ICnxHubTradeActivityImporter) must have been set up and registered with
        ///     BoDi (ObjectContainer) ideally in a Before step, otherwise creating a new instance of CnxHubAdminSteps will fail
        /// </summary>
        public CnxHubAdminSteps CnxHubAdminSteps
        {
            get
            {
                bool toAdd = GetStepDefinition(CnxHubAdminSteps.FullName) == null;
                CnxHubAdminSteps steps = (CnxHubAdminSteps)
                    GetStepDefinition(CnxHubAdminSteps.FullName) ??
                                         new CnxHubAdminSteps(ObjectContainer.Resolve<CnxTradeTableDataContext>(),
                                             ObjectContainer.Resolve<ICnxHubTradeActivityImporter>());
                if (toAdd)
                {
                    ObjectContainer.RegisterInstanceAs(steps);
                }
                return steps;
            }
        }

        protected static string[] IgnoredFieldsQuery(Table table)
        {
            string[] ignoredFieldsQuery = table.Rows.Select(row => row["ExcludedFields"]).ToArray();
            return ignoredFieldsQuery;
        }
    }
}