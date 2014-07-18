using System.Collections.Generic;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminStepBase : StepCentral
    {
        public new static readonly string FullName = typeof(CnxHubAdminStepBase).FullName; 
        public CnxHubAdminStepBase(CnxTradeTableDataContext cnxTradeTableDataContext,
            ICnxHubTradeActivityImporter cnxHubTradeActivityImporter) : base(cnxTradeTableDataContext)
        {
            CnxHubTradeActivityImporter = cnxHubTradeActivityImporter;
        }

        protected static IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        protected static ICnxHubTradeActivityImporter CnxHubTradeActivityImporter { get; private set; }
        protected DealSearchCriteria DealSearchCriteria { get; set; }

        [StepArgumentTransformation]
        public static IEnumerable<IncludedLogins> IncludedLoginsTransform(Table table)
        {
            return table.CreateSet<IncludedLogins>();
        }
    }
}