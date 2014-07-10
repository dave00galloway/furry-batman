using System.Collections.Generic;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminStepBase : StepCentral
    {
        public CnxHubAdminStepBase(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter) : base(cnxTradeTableDataContext)
        {
            CnxHubTradeActivityImporter = cnxHubTradeActivityImporter;
        }

        protected IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        protected ICnxHubTradeActivityImporter CnxHubTradeActivityImporter { get; private set; }

        [StepArgumentTransformation]
        public static IEnumerable<IncludedLogins> IncludedLoginsTransform(Table table)
        {
            return table.CreateSet<IncludedLogins>();
        }
    }
}