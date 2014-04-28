using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public class FileComparisonResult
    {
        public FileComparisonResult(List<string> expectedResults, List<string> actualResults, string comparison)
        {
            this.ExpectedResults = expectedResults;
            this.ActualResults = actualResults;
            this.Comparison = comparison;
        }

        public List<string> ExpectedResults { get; private set; }
        public List<string> ActualResults { get; private set; }
        public string Comparison { get; private set; }
    }
}