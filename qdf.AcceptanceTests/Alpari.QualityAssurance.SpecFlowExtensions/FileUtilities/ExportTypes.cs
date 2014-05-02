using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public enum ExportTypes
    {
        Unknown = 0,
        Csv = 1,
        Database = 2
    }

    public enum ExportParams
    {
        FileNamePath,
        ConnectionString,
        TableName
    }
}
