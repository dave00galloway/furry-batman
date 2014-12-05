using System.Collections.Generic;
using System.Linq;
using System.Net;
using Alpari.QA.Webdriver.Core.Elements;
using Alpari.QA.Webdriver.Core.Enums;
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

        /// <summary>
        ///     TODO:- move to PageBase, and then move body of method to an html element class
        /// </summary>
        /// <param name="tableBy"></param>
        /// <returns></returns>
        public HtmlTableData GetTableData(By tableBy)
        {
            var webTable = Driver.FindElement(tableBy);
            var doc = new HtmlDocument();
            doc.LoadHtml(webTable.GetAttribute(HtmlAttributes.InnerHtml));
            var data = new HtmlTableData();
            var columns =
                doc.DocumentNode.SelectNodes(".//tr")
                    .First()
                    .SelectNodes(".//th")
                    .Select(n => WebUtility.HtmlDecode(n.InnerText).Trim())
                    .ToList();
           
            foreach (var rowData in doc.DocumentNode.SelectNodes(".//" + HtmlAttributes.TableRow)
                .Skip(1)
                .Select(row => row.SelectNodes("th|td")
                .Select(n => WebUtility.HtmlDecode(n.InnerText)).ToList()))
            {
                data[rowData.First()] = new Dictionary<string, string>();
                for (var i = 0; i < columns.Count; i++)
                {
                    data[rowData.First()].Add(columns[i], rowData[i]);
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