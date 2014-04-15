using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public class FileComparisonResult
    {
        public List<string> ExpectedResults { get; private set; }
        public List<string> ActualResults { get; private set; }
        public string Comparison { get; private set; }

        public FileComparisonResult(List<string> ExpectedResults, List<string> ActualResults, string Comparison)
        {
            this.ExpectedResults = ExpectedResults;
            this.ActualResults = ActualResults;
            this.Comparison = Comparison;
        }
    }
}
