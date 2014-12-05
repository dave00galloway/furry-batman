using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using Alpari.QA.Webdriver.Core.Constants;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using HtmlAgilityPack;
using OpenQA.Selenium;

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
            var doc = tableBy.GetTableHtmlAsDoc(driver);
            var columns = doc.GetHtmlColumnNames();
            return doc.GetHtmlTableCellData(columns);
        }

        /// <summary>
        ///     Take an HtmlTableData object and convert it into an untyped data table,
        ///     assume that the row key is the sole primary key for the table,
        ///     and the key in each of the rows is the column header
        ///     Hopefully this will make more sense when its written!
        ///     Expecting overloads for swichting column and headers,
        ///     multiple primary keys, non standard format html tables etc
        /// </summary>
        /// <param name="htmlTableData"></param>
        /// <param name="primaryKey"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public static DataTable ConvertHtmlTableDataToDataTable(this HtmlTableData htmlTableData,
            string primaryKey = null, string tableName = null)
        {
            var table = new DataTable(tableName);
            
            foreach (var colName in htmlTableData.Values.First().Keys)
            //foreach (var colName in htmlTableData.Keys)
            {
                table.Columns.Add(new DataColumn(colName, typeof (string)));
            }
            table.SetPrimaryKey(new[] { primaryKey });
            foreach (var values in htmlTableData
                .Select(row => row.Value.Values.ToArray<object>()))
            {
                table.Rows.Add(values);
            }

            return table;
        }


        private static HtmlTableData GetHtmlTableCellData(this HtmlDocument doc, IReadOnlyList<string> columns)
        {
            var data = new HtmlTableData();
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

        private static List<string> GetHtmlColumnNames(this HtmlDocument doc)
        {
            var columns =
                doc.DocumentNode.SelectNodes(XmlExpressions.AllDescendants + HtmlAttributes.TableRow)
                    .First()
                    .SelectNodes(XmlExpressions.AllDescendants + HtmlAttributes.TableHeader)
                    .Select(n => WebUtility.HtmlDecode(n.InnerText).Trim())
                    .ToList();
            return columns;
        }

        private static HtmlDocument GetTableHtmlAsDoc(this By tableBy, IWebdriverCore driver)
        {
            var webTable = driver.FindElement(tableBy);
            var doc = new HtmlDocument();
            doc.LoadHtml(webTable.GetAttribute(HtmlAttributes.InnerHtml));
            return doc;
        }
    }
}