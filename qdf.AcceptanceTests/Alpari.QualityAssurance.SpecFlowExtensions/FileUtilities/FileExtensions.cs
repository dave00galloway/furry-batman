using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class FileExtensions
    {
        public static void ClearOutputDirectory(this string reportRoot)
        {
            if (System.IO.Directory.Exists(reportRoot))
            {
                foreach (string file in System.IO.Directory.GetFiles(reportRoot))
                {
                    System.IO.File.Delete(file);
                }

                foreach (string subDirectory in System.IO.Directory.GetDirectories(reportRoot))
                {
                    foreach (string file in System.IO.Directory.GetFiles(subDirectory))
                    {
                        System.IO.File.Delete(file);
                    }
                }
            }
            System.IO.Directory.CreateDirectory(reportRoot);
        }
    }
}
