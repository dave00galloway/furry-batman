using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Autofac.Core.Activators.Reflection;
using FluentAssertions;
using qdf.AcceptanceTests.Helpers;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps.SelfTest
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasWithLoadedFilesSteps : StepCentral
    {
        private readonly QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps _sharedSteps;

        public QdfAnalysisOfArsCcEcnDiffDeltasWithLoadedFilesSteps()
        {
            _sharedSteps = QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps;
        }

        [Given(@"I have loaded all ""(.*)"" files")]
        public void GivenIHaveLoadedAllFiles(string filePattern)
        {
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
                        _sharedSteps.DiffDeltaSummary.Add(fileInfo.Name,
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

        [Then(@"the combination with the highest diffdelta sum is ""(.*)"" with (.*)")]
        public void ThenTheCombinationWithTheHighestDiffdeltaSumIsWith(string combination, decimal amount)
        {
            _sharedSteps.DeltaSumDecimals.Values.Max().Should().Be(amount);
            _sharedSteps.DeltaSumDecimals[combination].Should().Be(amount);
        }

        [Then(@"the book with the highest diffdelta sum is ""(.*)"" with (.*)")]
        public void ThenTheBookWithTheHighestDiffdeltaSumIsWith(string book, Decimal amount)
        {
            _sharedSteps.DeltaSumByBook.Values.Max().Should().Be(amount);
            _sharedSteps.DeltaSumByBook[Convert.ToChar(book)].Should().Be(amount);
        }

        [Then(@"the server with the highest diffdelta sum is ""(.*)"" with (.*)")]
        public void ThenTheServerWithTheHighestDiffdeltaSumIsWith(string server, Decimal amount)
        {
            _sharedSteps.DeltaSumByServer.Values.Max().Should().Be(amount);
            _sharedSteps.DeltaSumByServer[server].Should().Be(amount);
        }

        [Then(@"the symbol with the highest diffdelta sum is ""(.*)"" with (.*)")]
        public void ThenTheSymbolWithTheHighestDiffdeltaSumIsWith(string symbol, Decimal amount)
        {
            _sharedSteps.DeltaSumBySymbol.Values.Max().Should().Be(amount);
            _sharedSteps.DeltaSumBySymbol[symbol].Should().Be(amount);
        }    
    }
}
