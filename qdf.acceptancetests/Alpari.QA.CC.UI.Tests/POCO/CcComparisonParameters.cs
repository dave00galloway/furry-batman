namespace Alpari.QA.CC.UI.Tests.POCO
{
    public class CcComparisonParameters
    {
        /// <summary>
        ///     indicates the driver to load for the environment which either is production, 
        ///     or has the current production version of CC
        /// </summary>
        public string CcCurrent { get; set; }

        /// <summary>
        ///     indicates the driver to load for the envirnment contianing the version of cc under test
        /// </summary>
        public string CcNew { get; set; }

        public string MonitorFor { get; set; }

        public string MonitorEvery { get; set; }
    }
}