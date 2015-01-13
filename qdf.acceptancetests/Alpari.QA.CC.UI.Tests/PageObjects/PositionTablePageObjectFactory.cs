using System.Diagnostics;
using Alpari.QA.Webdriver.Core;
using OpenQA.Selenium;

namespace Alpari.QA.CC.UI.Tests.PageObjects
{
    /// <summary>
    /// Currently a bit naff but does allow swapping of the member fields.
    /// Might replace with xml loading of element definitions to avoid OCP violation
    /// </summary>
    public static class PositionTablePageObjectFactory
    {
        public static IPositionTablePageObject Create(this IWebdriverCore webdriverCore, string version)
        {
            IPositionTableBys positionTableBys = null;
            var positionTableBy = new PositionTableBy();

            switch (version)
            {
                case "4.5":
                    positionTableBys = new PositionTableBy4_5(positionTableBy);
                    break;

                case "4.6":
                    positionTableBys = new PositionTableBy4_6(positionTableBy);
                    break;
            }

            return new PositionTablePageObject(webdriverCore, positionTableBys);
        }
    }

    internal class PositionTableBy : IPositionTableBys
    {
        public By PositionTableSelector
        {
            get { return PositionTableBys.PositionTableSelector; }
            set { PositionTableBys.PositionTableSelector = value; }
        }

        public By PositionSettingsButton
        {
            get { return PositionTableBys.PositionSettingsButton; }
            set { PositionTableBys.PositionSettingsButton = value; }
        }

        public By BBookSelector
        {
            get { return PositionTableBys.BBookSelector; }
        }

        public By ABookSelector
        {
            get { return PositionTableBys.ABookSelector; }
        }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        public IPositionTableBys PositionTableBys { get; set; }

        public void SetCommonBys(IPositionTableBys positionTableBy)
        {
            PositionTableBys = this;
            positionTableBy.PositionTableSelector = PositionTableByInvariants.PositionTableSelector;
            positionTableBy.PositionSettingsButton = PositionTableByInvariants.PositionSettingsButton;
            positionTableBy.PositionTableBys = this;
        }
    }

    public interface IPositionTableBys
    {
        By PositionTableSelector { get; set; }
        By PositionSettingsButton { get; set; }
        By BBookSelector { get; }
        By ABookSelector { get; }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        IPositionTableBys PositionTableBys { get; set; }
    }


    internal static class PositionTableByInvariants
    {
        public static readonly By PositionTableSelector = By.CssSelector("#position-table");
        public static readonly By PositionSettingsButton = By.CssSelector("#position-setting-button");
    }

    internal class PositionTableBy4_5 : IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#bookType-option-B");
        private readonly By _aBookSelector = By.CssSelector("#bookType-option-A");

        public PositionTableBy4_5(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }

        public By PositionTableSelector { get; set; }
        public By PositionSettingsButton { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public By ABookSelector
        {
            get { return _aBookSelector; }
        }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        public IPositionTableBys PositionTableBys { get; set; }
    }

    internal class PositionTableBy4_6 : IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#viewType-option-B");
        private readonly By _aBookSelector = By.CssSelector("#viewType-option-A");

        public PositionTableBy4_6(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }

        public By PositionTableSelector { get; set; }
        public By PositionSettingsButton { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public By ABookSelector
        {
            get { return _aBookSelector; }
        }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        public IPositionTableBys PositionTableBys { get; set; }
    }
}