using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Drawing;
using System.Windows.Forms.DataVisualization.Charting;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// provides methods for translating enumerable types to graphs. At present the output is .png files, but the method signatures could be reused to create html, excel etc
    /// </summary>
    public static class EnumerableToGraphExtensions
    {
        /// <summary>
        /// adapted from
        /// http://timbar.blogspot.com/2012/04/creating-chart-programmatically-in-c.html
        /// as are all the methods in this class. This one ignores all parameters and produces a hardcoded chart from the original code sample
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="enumerable"></param>
        public static void CreateChart<T>(this IEnumerable<T> enumerable)
        {
            // set up some data
            var xvals = new[]
                {
                    new DateTime(2012, 4, 4), 
                    new DateTime(2012, 4, 5), 
                    new DateTime(2012, 4, 6), 
                    new DateTime(2012, 4, 7)
                };
            var yvals = new[] { 1, 3, 7, 12 };

            // create the chart
            var chart = new Chart();
            chart.Size = new Size(600, 250);

            var chartArea = new ChartArea();
            chartArea.AxisX.LabelStyle.Format = "dd/MMM\nhh:mm";
            chartArea.AxisX.MajorGrid.LineColor = Color.LightGray;
            //chartArea.AxisX.Interval = 2;
            chartArea.AxisY.MajorGrid.LineColor = Color.LightGray;
            chartArea.AxisX.LabelStyle.Font = new Font("Consolas", 8);
            chartArea.AxisY.LabelStyle.Font = new Font("Consolas", 8);
            chart.ChartAreas.Add(chartArea);

            var series = new Series();
            series.Name = "Series1";
            series.ChartType = SeriesChartType.FastLine;
            series.XValueType = ChartValueType.DateTime;
            chart.Series.Add(series);

            // bind the datapoints
            chart.Series["Series1"].Points.DataBindXY(xvals, yvals);

            // copy the series and manipulate the copy
            chart.DataManipulator.CopySeriesValues("Series1", "Series2");
            chart.DataManipulator.FinancialFormula(
                FinancialFormula.WeightedMovingAverage,
                "Series2"
            );
            chart.Series["Series2"].ChartType = SeriesChartType.FastLine;

            // draw!
            chart.Invalidate();

            // write out a file
            chart.SaveImage("chart.png", ChartImageFormat.Png);
            
        }

        /// <summary>
        /// Create a line graph of one or more series of data in the named properties of the enumerable object as yvals against a single Xval series
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="TX"></typeparam>
        /// <typeparam name="TY"></typeparam>
        /// <param name="enumerable"></param>
        /// <param name="xvals">one or more named properties of the class to use as xvals</param>
        /// <param name="yvals"></param>
        public static void EnumerableToLineGraph<T>(this IEnumerable<T> enumerable, DataSeriesParameters xvalParams, IEnumerable<DataSeriesParameters> yvalParams)
        {
            // set up some data
            //var xvals = new[]
            //    {
            //        new DateTime(2012, 4, 4), 
            //        new DateTime(2012, 4, 5), 
            //        new DateTime(2012, 4, 6), 
            //        new DateTime(2012, 4, 7)
            //    };
            //get xvals
            //var xvals = enumerable.
            //var xvals = enumerable.Select(item => item.GetProperties(new List<string> {xvalParams.PropertyName}).Select(x=>x.GetValue(item).ToSafeString())).Cast<object>().ToList();
            var enumeratedList = enumerable as IList<T> ?? enumerable.ToList();
            var xvals = enumeratedList.Select(item => item.GetProperties(new List<string> {xvalParams.PropertyName}).Select(x => x.GetValue(item)).FirstOrDefault()).ToList();
            //if (xvalParams.ChartValueType == ChartValueType.DateTime)
            //{
            //   // for
            //}
            //var yvals = new[] { 1, 3, 7, 12 };

            // create the chart
            var chart = new Chart();
            chart.Size = new Size(600, 250);

            var chartArea = new ChartArea();
            chartArea.AxisX.LabelStyle.Format = "dd/MMM\nhh:mm";
            chartArea.AxisX.MajorGrid.LineColor = Color.LightGray;
            //chartArea.AxisX.Interval = 2;
            chartArea.AxisY.MajorGrid.LineColor = Color.LightGray;
            chartArea.AxisX.LabelStyle.Font = new Font("Consolas", 8);
            chartArea.AxisY.LabelStyle.Font = new Font("Consolas", 8);
            chart.ChartAreas.Add(chartArea);

            foreach (DataSeriesParameters yvalParam in yvalParams)
            {
                var series = new Series();
                //series.Name = "Series1";
                var yvals = enumeratedList.Select(item => item.GetProperties(new List<string> { yvalParam.PropertyName }).Select(x => x.GetValue(item)).FirstOrDefault()).ToList();
                series.Name = yvalParam.SeriesName!= ""? yvalParam.SeriesName: yvalParam.PropertyName;
                series.ChartType = SeriesChartType.FastLine;
                //series.XValueType = ChartValueType.DateTime;
                series.XValueType = xvalParams.ChartValueType;
                chart.Series.Add(series);

                // bind the datapoints
                chart.Series[series.Name].Points.DataBindXY(xvals, yvals);                
            }



            //// copy the series and manipulate the copy -- specialist method - not needed
            //chart.DataManipulator.CopySeriesValues("Series1", "Series2");
            //chart.DataManipulator.FinancialFormula(
            //    FinancialFormula.WeightedMovingAverage,
            //    "Series2"
            //);
            //chart.Series["Series2"].ChartType = SeriesChartType.FastLine;

            // draw!
            chart.Invalidate();

            // write out a file
            chart.SaveImage("chart.png", ChartImageFormat.Png);

        }

        public class DataSeriesParameters
        {
            public string PropertyName { get; set; }
            public string SeriesName { get; set; }
            public ChartValueType ChartValueType { get; set; }
        }
    }
}
