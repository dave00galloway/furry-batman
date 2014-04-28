using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
// ReSharper disable once UnusedMember.Global - used in client tests
    public class FileComparisonResult
    {
        public FileComparisonResult(List<string> expectedResults, List<string> actualResults, string comparison)
        {
            ExpectedResults = expectedResults;
            ActualResults = actualResults;
            Comparison = comparison;
        }

        public List<string> ExpectedResults { get; private set; }
        public List<string> ActualResults { get; private set; }
        public string Comparison { get; private set; }
    }
}