using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public class FileComparisonResult
    {
        public FileComparisonResult(List<string> ExpectedResults, List<string> ActualResults, string Comparison)
        {
            this.ExpectedResults = ExpectedResults;
            this.ActualResults = ActualResults;
            this.Comparison = Comparison;
        }

        public List<string> ExpectedResults { get; private set; }
        public List<string> ActualResults { get; private set; }
        public string Comparison { get; private set; }
    }
}