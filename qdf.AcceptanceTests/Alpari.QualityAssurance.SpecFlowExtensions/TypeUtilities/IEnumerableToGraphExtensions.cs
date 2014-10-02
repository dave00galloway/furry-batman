using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms.DataVisualization.Charting;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     provides methods for translating enumerable types to graphs. At present the output is .png files, but the method
    ///     signatures could be reused to create html, excel etc
    /// </summary>
    public static class EnumerableToGraphExtensions
    {
        /// <summary>
        ///     adapted from
        ///     http://timbar.blogspot.com/2012/04/creating-chart-programmatically-in-c.html
        ///     as are all the methods in this class. This one ignores all parameters and produces a hardcoded chart from the
        ///     original code sample
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
            var yvals = new[] {1, 3, 7, 12};

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
        ///     Create a line graph of one or more series of data in the named properties of the enumerable object as yvals against
        ///     a single Xval series
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="yvalParams">one or more named properties of the class to use as yvals</param>
        /// <param name="chartOptions"></param>
        /// <param name="enumerable"></param>
        /// <param name="xvalParams"> named property of the class to use as xvals</param>
        public static void EnumerableToLineGraph<T>(this IEnumerable<T> enumerable, DataSeriesParameters xvalParams,
            IEnumerable<DataSeriesParameters> yvalParams, ChartOptions chartOptions = null)
        {
            if (chartOptions == null)
            {
                chartOptions = new ChartOptions();
            }
            IList<T> enumeratedList = enumerable as IList<T> ?? enumerable.ToList();
            List<object> xvals =
                enumeratedList.Select(
                    item =>
                        item.GetProperties(new List<string> {xvalParams.PropertyName})
                            .Select(x => x.GetValue(item))
                            .FirstOrDefault()).ToList();


            // create the chart
            var chart = new Chart();
            chart.Size = new Size(chartOptions.Width, chartOptions.Height);

            var chartArea = new ChartArea();
            chartArea.AxisX.LabelStyle.Format = xvalParams.LabelStyleFormat;
            chartArea.AxisX.MajorGrid.LineColor = chartOptions.AxisXMajorGridLineColor;
            chartArea.AxisX.MajorGrid.Interval = chartOptions.AxisXMajorGridInterval;
            if (chartOptions.AxisXMajorGridInterval != 0)
            {
                chartArea.AxisX.Interval = chartOptions.AxisXMajorGridInterval;
            }
            //chartArea.AxisX.Interval = chartOptions.
            chartArea.AxisY.MajorGrid.LineColor = chartOptions.AxisYMajorGridLineColor;
            chartArea.AxisX.LabelStyle.Font = chartOptions.AxisXLabelStyleFont; 
            chartArea.AxisY.LabelStyle.Font = chartOptions.AxisYLabelStyleFont;
            chart.ChartAreas.Add(chartArea);
            chart.Titles.Add(new Title(chartOptions.Name, chartOptions.TitleDocking , new Font(chartOptions.TitleFont, chartOptions.TitleFontSize),chartOptions.TitleColor));

            foreach (DataSeriesParameters yvalParam in yvalParams)
            {
                var series = new Series();
                List<object> yvals =
                    enumeratedList.Select(
                        item =>
                            item.GetProperties(new List<string> {yvalParam.PropertyName})
                                .Select(x => x.GetValue(item))
                                .FirstOrDefault()).ToList();
                series.Name = yvalParam.SeriesName != "" ? yvalParam.SeriesName : yvalParam.PropertyName;
                series.ChartType = SeriesChartType.FastLine;
                series.XValueType = xvalParams.ChartValueType;
                chart.Series.Add(series);
                chart.Series[series.Name].Name = series.Name;
                
                // bind the datapoints
                chart.Series[series.Name].Points.DataBindXY(xvals, yvals);

                //display legend
                chart.Legends.Add(new Legend(series.Name) {Docking = Docking.Right});

            }

            // draw!
            chart.Invalidate();

            // write out a file - will error if file exists?
            try
            {
                chart.SaveImage(
                    String.Format("{0}{1}.{2}", chartOptions.FilePath, chartOptions.Name,
                        chartOptions.ChartImageFormat.ToString().ToLower()), chartOptions.ChartImageFormat);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        public class ChartOptions
        {
            public ChartOptions()
            {
                if (Width == default (int))
                {
                    Width = 1920;
                }
                if (Height == default (int))
                {
                    Height = 1200;
                }
                if (ChartImageFormat == default(ChartImageFormat))
                {
                    ChartImageFormat = ChartImageFormat.Png;
                }
                if (Name == default(string))
                {
                    Name = "Graph";
                }
                if (TitleFontSize == 0)
                {
                    TitleFontSize = 20;
                }
                //if (TitleDocking == default (Docking))
                //{
                //    TitleDocking = Docking.Top;
                //}
                if (TitleFont == null)
                {
                    TitleFont = FontFamily.GenericSansSerif;
                }
                if (TitleColor == default (Color))
                {
                    TitleColor = Color.Black;
                }
                if (AxisXMajorGridLineColor == default (Color))
                {
                    AxisXMajorGridLineColor = Color.LightGray;
                }
                if (AxisYMajorGridLineColor == default(Color))
                {
                    AxisYMajorGridLineColor = Color.LightGray;
                }
                if (AxisXLabelStyleFont == null) 
                {
                    AxisXLabelStyleFont = new Font("Consolas", 8);
                }
                if (AxisYLabelStyleFont == null) 
                {
                    AxisYLabelStyleFont = new Font("Consolas", 8);
                }
                //if (AxisXMajorGridInterval == default (double))
                //{
                //    AxisXMajorGridInterval = 3600;
                //}
            }

            public int Width { get; set; }

            public int Height { get; set; }
            public ChartImageFormat ChartImageFormat { get; set; }
            public string FilePath { get; set; }
            public string Name { get; set; }
            public float TitleFontSize { get; set; }
            public Docking TitleDocking { get; set; }
            public FontFamily TitleFont { get; set; }
            public Color TitleColor { get; set; }
            public Color AxisXMajorGridLineColor { get; set; }
            public Color AxisYMajorGridLineColor { get; set; }
            public Font AxisXLabelStyleFont { get; set; }
            public Font AxisYLabelStyleFont { get; set; }
            public double AxisXMajorGridInterval { get; set; }
        }

        public class DataSeriesParameters
        {
            public DataSeriesParameters()
            {
                if (LabelStyleFormat == default (string))
                {
                    LabelStyleFormat = "dd/MMM\nhh:mm";
                }
            }

            public string PropertyName { get; set; }
            public string SeriesName { get; set; }
            public ChartValueType ChartValueType { get; set; }

            /// <summary>
            ///     the LabelStyle.Format to apply - "dd/MMM\nhh:mm" is assumed if empty
            /// </summary>
            public string LabelStyleFormat { get; set; }
        }
    }
}