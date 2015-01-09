namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     A Data point containing values being compared
    ///     TODO: create a generic version which allows types to be set for the key and value types, and thus allow diffs to be
    ///     calculated
    /// </summary>
    public class TrendData
    {
        /// <summary>
        ///     the index linking 2 values together represented as a string. Typically this will be a DateTime or TimeStamp, but
        ///     could be a positional index, or a database primary key etc.
        /// </summary>
        public string Key { get; set; }

        public string OrginalSeriesName { get; set; }
        public string NewSeriesName { get; set; }
        public string OrginalSeriesValue { get; set; }
        public string NewSeriesValue { get; set; }
    }
}