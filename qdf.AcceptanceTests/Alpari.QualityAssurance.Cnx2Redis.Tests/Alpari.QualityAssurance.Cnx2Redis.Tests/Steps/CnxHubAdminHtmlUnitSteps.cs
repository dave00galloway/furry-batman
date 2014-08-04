using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NHtmlUnit;
using NHtmlUnit.Html;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class CnxHubAdminHtmlUnitSteps
    {
        [Given(@"I have connected to currenex hub admin with htmlunit")]
        public void GivenIHaveConnectedToCurrenexHubAdminWithHtmlunit()
        {
            string url = "https://pret.currenex.com/webadmin/loginAction.action";
            WebClient wc = new WebClient(BrowserVersion.CHROME);
            wc.Options.JavaScriptEnabled = true;

            HtmlPage currentPage = (HtmlPage) wc.GetPage(url);
            HtmlInput userName =  (HtmlInput) currentPage.GetHtmlElementById("username");
            //userName.ValueAttribute = 


        }

        [When(@"I request the trade activity report as csv with htmlunit")]
        public void WhenIRequestTheTradeActivityReportAsCsvWithHtmlunit()
        {
            ScenarioContext.Current.Pending();
        }

    }
}
