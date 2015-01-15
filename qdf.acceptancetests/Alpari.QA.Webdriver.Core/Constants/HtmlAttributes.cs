namespace Alpari.QA.Webdriver.Core.Constants
{
//    /// <summary>
//    /// enumeration of possiblke values to be used in IWebelement.GetAttribute
//    /// usage e.g. HtmlAttributes.innerHTML.ToString()
//    /// </summary>
//    public enum HtmlAttributes
//    {
//// ReSharper disable InconsistentNaming
//        innerHTML
//// ReSharper restore InconsistentNaming
//    }

    /// <summary>
    /// config class holding common Html Attributes and tag names etc
    /// </summary>
    public static class HtmlAttributes
    {
        public const string InnerHtml = "innerHTML";
        public const string TableRow = "tr";
        public const string TableHeader = "th";
        public const string TableCell = "th|td";
        public const string Class = "class";
    }
    
}
