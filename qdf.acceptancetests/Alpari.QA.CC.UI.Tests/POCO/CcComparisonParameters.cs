using System;
using OpenQA.Selenium.Support.UI;

namespace Alpari.QA.CC.UI.Tests.POCO
{
    public class CcComparisonParameters
    {
        private string _book = "B"; // set a default value for Book

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
        //CcCurrentVersion | CcNewVersion
        public string CcCurrentVersion { get; set; }
        public string CcNewVersion { get; set; }

        public string Book
        {
            get { return _book; }
            set { _book = value; }
        }

        #region PositionSettings
        private string _select = "None";
        private int _minimumServers = 11;
        private int _minimumSymbols = 11;

        /// <summary>
        /// Since its problematic to determine if "ALL" symbols/servers are selected, the actual verification of this will be done by the following "minimum" fields
        /// </summary>
        public String Select
        {
            get { return _select; }
            set { _select = value; }
        }

        public int MinimumServers
        {
            get { return _minimumServers; }
            set { _minimumServers = value; }
        }

        public int MinimumSymbols
        {
            get { return _minimumSymbols; }
            set { _minimumSymbols = value; }
        }
        /// <summary>
        /// Has the position setting been set or not?
        /// </summary>
        public bool Set { get; set; }

        #endregion
    }
}