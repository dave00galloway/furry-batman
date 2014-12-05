using System.Linq;
using Alpari.QA.Webdriver.Core.Elements;
using Alpari.QA.Webdriver.Core.Enums;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using HtmlAgilityPack;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace Alpari.QA.Webdriver.Core
{
    //TODO:- decide if the Webdriver core will hold multipe selenium instances, or have a container for Cores
    public class WebdriverCore : IWebdriverCore
    {
        private IWebDriver Driver { get; set; }

        public void OpenPage(string url)
        {
            GetDriver().Navigate().GoToUrl(url);
        }

        public IWebElement FindElement(By by)
        {
            //TODO:- add sync, logging etc...
            return Driver.FindElement(by);
        }

//http://stackoverflow.com/questions/655603/html-agility-pack-parsing-tables
//var query = from table in doc.DocumentNode.SelectNodes("//table").Cast<HtmlNode>()
//            from row in table.SelectNodes("tr").Cast<HtmlNode>()
//            from cell in row.SelectNodes("th|td").Cast<HtmlNode>()
//            select new {Table = table.Id, CellText = cell.InnerText};

//foreach(var cell in query) {
//    Console.WriteLine("{0}: {1}", cell.Table, cell.CellText);
//}

        public void Quit()
        {
            //TODO:- detect if running as a container and quit all instances
            Driver.Quit();
        }

        public HtmlTableData GetTableData(By tableBy)
        {
            var webTable = Driver.FindElement(tableBy);
            var doc = new HtmlDocument();
            doc.LoadHtml(webTable.GetAttribute(HtmlAttributes.InnerHtml));
            var data = new HtmlTableData();
            var columns = doc.DocumentNode.SelectNodes(HtmlAttributes.TableRow).First().SelectNodes("th|td").Select(n=>n.InnerText).ToList();

            foreach (var row in doc.DocumentNode.SelectNodes(HtmlAttributes.TableRow).Skip(1))
            {
                var rowData = row.SelectNodes("th|td").Select(n=>n.InnerText).ToList();
                for (int i = 0; i < columns.Count; i++)
                {
                    var column = columns[i];
                    data[rowData.First()].Add(column, rowData[i]);
                }
            }
            return data;
        }

        /// <summary>
        ///     very lazy way of lazily initialising a webdriver
        /// </summary>
        /// <returns></returns>
        protected virtual IWebDriver GetDriver()
        {
            return Driver ?? (Driver = new ChromeDriver());
        }
    }
}