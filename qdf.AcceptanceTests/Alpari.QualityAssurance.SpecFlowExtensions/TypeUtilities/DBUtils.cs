using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// extenions for tasks associated with database work, other than creating connections and queries
    /// </summary>
    public static class DBUtils
    {
        public static Dictionary<string, string> ParseConnectionString(this string toParse)
        {
            Dictionary<string, string> stringParts = new Dictionary<string, string>();
            stringParts = toParse.Split(';').Select(t => t.Split(new char[] { '=' }, 2)).ToDictionary(t => t[0].Trim(), t => t[1].Trim(), StringComparer.InvariantCultureIgnoreCase);

            return stringParts;
        }
    }
}
