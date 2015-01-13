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

        public String Select
        {
            get { return _select; }
            set { _select = value; }
        }
        #endregion
    }
}