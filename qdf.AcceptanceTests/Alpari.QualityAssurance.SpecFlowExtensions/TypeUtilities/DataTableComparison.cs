namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;

    public class DataTableComparison
    {
        public DataTableComparison() { }

        public List<DataRow> MissingInCompareWith { get; set; }
    }
}
