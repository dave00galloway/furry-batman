using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Autofac.Core.Activators.Reflection;
using qdf.AcceptanceTests.Helpers;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps.SelfTest
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasWithLoadedFilesSteps : StepCentral
    {
        [Given(@"I have loaded all ""(.*)"" files")]
        public void GivenIHaveLoadedAllFiles(string filePattern)
        {
            var qdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps =
                QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps;
            var codeBase = System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase;
            if (codeBase != null)
            {
                var path = Path.GetDirectoryName(codeBase);
                if (path != null)
                {
                    var directoryInfo = new DirectoryInfo(new Uri(path).LocalPath);
                    var fileList = directoryInfo.GetFiles(String.Format("*{0}", filePattern), SearchOption.AllDirectories);
                    foreach (var fileInfo in fileList)
                    {
                        qdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps.DiffDeltaSummary.Add(
                            fileInfo.FullName.CsvToList<DiffDeltaSummary>(","));
                    }                    
                }
                else
                {
                    throw new FileLoadException(codeBase);
                }
            }
            else
            {
                throw new FileLoadException();
            }

        }

    }
}
