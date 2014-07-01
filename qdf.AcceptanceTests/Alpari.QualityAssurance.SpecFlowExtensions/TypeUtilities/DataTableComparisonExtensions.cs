using System;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using FluentAssertions;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public static class DataTableComparisonExtensions
    {
        public static void QueryDifferences(this DataTableComparison diffs, int diffCount, string diffType)
        {
            if (diffCount > 0)
            {
                diffs.CheckForDifferences().Should().NotBeNullOrWhiteSpace();
            }
            
            switch (diffType.ToLower())
            {
                case "mismatch":
                case "mismatches":
                case "field diffs":
                case "field diff":
                    diffs.FieldDifferences.Rows.Should().HaveCount(diffCount);
                    break;
                case "extra":
                    diffs.AdditionalInCompareWith.Should().HaveCount(diffCount);
                    break;
                case "missing":
                    diffs.MissingInCompareWith.Should().HaveCount(diffCount);
                    break;
                default:
                    throw new ArgumentException("diffType {0} not recognised", diffType);
            }
        }

        public static void QueryDifferences(this DataTableComparison diffs, int diffCount, string diffType, ExportParameters exportParameters)
        {
            if (diffCount > 0)
            {
                diffs.CheckForDifferences(exportParameters).Should().NotBeNullOrWhiteSpace();
            }

            switch (diffType.ToLower())
            {
                case "mismatch":
                case "mismatches":
                case "field diffs":
                case "field diff":
                    diffs.FieldDifferences.Rows.Should().HaveCount(diffCount);
                    break;
                case "extra":
                    diffs.AdditionalInCompareWith.Should().HaveCount(diffCount);
                    break;
                case "missing":
                    diffs.MissingInCompareWith.Should().HaveCount(diffCount);
                    break;
                default:
                    throw new ArgumentException("diffType {0} not recognised", diffType);
            }
        } 
    }
}