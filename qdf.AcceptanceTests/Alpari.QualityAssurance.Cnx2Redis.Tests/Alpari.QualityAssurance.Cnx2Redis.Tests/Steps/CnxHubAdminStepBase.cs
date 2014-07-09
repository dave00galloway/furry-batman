using System;
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
        public CnxHubAdminStepBase(CnxTradeTableDataContext cnxTradeTableDataContext) : base(cnxTradeTableDataContext)
        {
        }

        protected IEnumerable<IncludedLogins> IncludedLoginsList { get; set; }
        protected List<CnxTradeActivity> CnxTradeActivityList { get; set; }
        protected DateTime EarliestTradeActivityDateTime { get; set; }
        protected DateTime LatestTradeActivityDateTime { get; set; }

        [StepArgumentTransformation]
        public static IEnumerable<IncludedLogins> IncludedLoginsTransform(Table table)
        {
            return table.CreateSet<IncludedLogins>();
        }
    }
}