using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Alpari.QualityAssurance.SpecFlowExtensions;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System.Configuration;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationStepBase
    {
        public static void SetupQdfDealQuery(QdfDealParameters entry)
        {
            var start = entry.startTime != null ? entry.startTime : ConfigurationManager.AppSettings["defaultStartTime"];
            var end = entry.endTime != null ? entry.endTime : ConfigurationManager.AppSettings["defaultEndTime"];
            entry.convertedStartTime = start.GetTimeFromShortCode();
            entry.convertedEndTime = end.GetTimeFromShortCode(entry.convertedStartTime);
        }

        [StepArgumentTransformation]
        public static IEnumerable<QdfDealParameters> ErrorsTransform(Table table)
        {
            return table.CreateSet<QdfDealParameters>();
        }
    }
}
