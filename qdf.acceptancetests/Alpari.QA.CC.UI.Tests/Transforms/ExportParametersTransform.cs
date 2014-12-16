//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
//using TechTalk.SpecFlow;
//using TechTalk.SpecFlow.Assist;

//namespace Alpari.QA.CC.UI.Tests.Transforms
//{
//    [Binding]
//    public class ExportParametersTransform
//    {
//        [StepArgumentTransformation]
//        public static ExportParameters QuoteSearchParametersTransform(Table table)
//        {
//            var parameters = table.CreateInstance<ExportParameters>();
//            if (parameters.ExportType == ExportTypes.Csv || parameters.ExportType == ExportTypes.DataTableToCsv)
//            {
//                parameters.Path = ScenarioOutputDirectory;
//            }
//            return parameters;
//        }
//    }
//}
