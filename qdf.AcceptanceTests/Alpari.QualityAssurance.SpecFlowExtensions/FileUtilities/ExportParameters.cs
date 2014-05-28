using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    /// class for holding info about a specific file import/export
    /// </summary>
    public class ExportParameters
    {
        public ExportTypes ExportType { get; set; }
        public string FileName { get; set; }
        public string Path { get; set; }
    }
}
