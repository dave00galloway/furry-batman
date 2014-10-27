using System.Collections.Generic;
using System.Configuration;
using Alpari.QualityAssurance.SecureMyPassword;

namespace Alpari.QA.QDF.Test.Domain.DataContexts.CC
{
    /// <summary>
    ///     Class allowing access to multiple cc instances using different connection strings
    /// </summary>
    public class CapitalCalculationDataContextPool
    {
        private CapitalCalculationDataContextPoolParams _capitalCalculationDataContextPoolParams;

        public CapitalCalculationDataContextPool(
            IDictionary<string, CapitalCalculationDataContext> capitalCalculationDataContexts)
        {
            CapitalCalculationDataContexts = capitalCalculationDataContexts;
        }

        public IDictionary<string, CapitalCalculationDataContext> CapitalCalculationDataContexts { get; set; }

        public CapitalCalculationDataContextPoolParams CapitalCalculationDataContextPoolParams
        {
            get { return _capitalCalculationDataContextPoolParams; }
            set
            {
                _capitalCalculationDataContextPoolParams = value;
                CapitalCalculationDataContexts.Add(value.Connection1, new CapitalCalculationDataContext(
                    ConfigurationManager.ConnectionStrings[value.Connection1].ConnectionString
                        .UnProtect('_')));
                CapitalCalculationDataContexts.Add(value.Connection2, new CapitalCalculationDataContext(
                    ConfigurationManager.ConnectionStrings[value.Connection2].ConnectionString
                        .UnProtect('_')));
            }
        }
    }

    public class CapitalCalculationDataContextPoolParams
    {
        public string Connection1 { get; set; }
        public string Connection2 { get; set; }
    }
}