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

    public class PositionTableBy : IPositionTableBys
    {
        public By PositionTableSelector { get; set; }
        public By BBookSelector { get; private set; }
        public PositionTableBy PositionTableBys { get; set; }

        public void SetCommonBys(IPositionTableBys positionTableBy)
        {
            PositionTableSelector = PositionTableByInvariants.PositionTableSelector;
            PositionTableBys = this;
            positionTableBy.PositionTableBys = this;
            positionTableBy.PositionTableSelector = PositionTableSelector;
            BBookSelector = null;
        }
    }

    public interface IPositionTableBys
    {
        By PositionTableSelector { get; set; }
        By BBookSelector { get; }
        PositionTableBy PositionTableBys { get; set; }
    }


    internal static class PositionTableByInvariants
    {
        public static readonly By PositionTableSelector = By.CssSelector("#position-table");
    }

    internal class PositionTableBy4_5 : IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#bookType-option-B");

        public PositionTableBy4_5(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }

        public By PositionTableSelector { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public PositionTableBy PositionTableBys { get; set; }
    }

    internal class PositionTableBy4_6 : IPositionTableBys
    {
        private readonly By _bBookSelector = By.CssSelector("#viewType-option-B");

        public PositionTableBy4_6(PositionTableBy positionTableBy)
        {
            positionTableBy.SetCommonBys(this);
        }

        public By PositionTableSelector { get; set; }

        public By BBookSelector
        {
            get { return _bBookSelector; }
        }

        public PositionTableBy PositionTableBys { get; set; }
    }
}