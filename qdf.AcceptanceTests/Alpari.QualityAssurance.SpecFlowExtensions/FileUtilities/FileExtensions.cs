using System.IO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class FileExtensions
    {
        public static void ClearOutputDirectory(this string reportRoot)
        {
            if (Directory.Exists(reportRoot))
            {
                foreach (string file in Directory.GetFiles(reportRoot))
                {
                    File.Delete(file);
                }

                foreach (string subDirectory in Directory.GetDirectories(reportRoot))
                {
                    foreach (string file in Directory.GetFiles(subDirectory))
                    {
                        File.Delete(file);
                    }
                }
            }
            Directory.CreateDirectory(reportRoot);
        }
    }
}