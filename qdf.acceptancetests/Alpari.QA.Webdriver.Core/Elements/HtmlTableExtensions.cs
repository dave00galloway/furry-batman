using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Alpari.QA.Webdriver.Core.Constants;
using HtmlAgilityPack;
using OpenQA.Selenium;
using OpenQA.Selenium.Safari.Internal;

namespace Alpari.QA.Webdriver.Core.Elements
{
    public static class HtmlTableExtensions
    {
        /// <summary>
        ///     based on an idea from http://stackoverflow.com/questions/655603/html-agility-pack-parsing-tables
        /// </summary>
        /// <param name="tableBy"></param>
        /// <param name="driver"></param>
        /// <returns></returns>
        public static HtmlTableData GetTableData(this By tableBy, IWebdriverCore driver)
        {
            var webTable = driver.FindElement(tableBy);
            var doc = new HtmlDocument();
            doc.LoadHtml(webTable.GetAttribute(HtmlAttributes.InnerHtml));
            var data = new HtmlTableData();
            var columns =
                doc.DocumentNode.SelectNodes(XmlExpressions.AllDescendants + HtmlAttributes.TableRow)
                    .First()
                    .SelectNodes(XmlExpressions.AllDescendants + HtmlAttributes.TableHeader)
                    .Select(n => WebUtility.HtmlDecode(n.InnerText).Trim())
                    .ToList();

            foreach (
                var rowData in doc.DocumentNode.SelectNodes(XmlExpressions.AllDescendants + HtmlAttributes.TableRow)
                    .Skip(1)
                    .Select(row => row.SelectNodes(HtmlAttributes.TableCell)
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
    }
}
