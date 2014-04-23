using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using NUnit.Framework;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.TypedDataTables;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.Helpers
{
    /// <summary>
    /// Class containing methods for aggregating CC and QDF Data to put them into comparable formats
    /// </summary>
    public class QDFCCDataReconciliation
    {
        public CCToolData CCToolData { get; private set; }
        public List<Deal> QDFDeals { get; private set; }
        public List<QDFDealPosition> QDFDealPositions { get; private set; }
        public List<CCToolPosition> CCToolPositions { get; private set; }

        public QDFCCDataReconciliation(CCToolData cCToolData, List<Deal> qDFDeals)
        {
            this.CCToolData = cCToolData;
            this.QDFDeals = qDFDeals;
        }

        public void AggregateQDFDeals()
        {
            //should work, but always ends up with non-unique groupings, and the same number of deals as groups!
            //var aggregatedDeals = QDFDeals.GroupBy(x => new QDFDealPositionGrouping()
            //                                                    {
            //                                                        Book = x.Book,
            //                                                        Instrument = x.Instrument,
            //                                                        ServerId = x.ServerId//,
            //                                                        //Side = x.Side
            //                                                    }
            //                                       )
            //answer - group using an anonymous type. This works!
            var aggregatedDeals = QDFDeals.GroupBy(x => new
                                                            {
                                                                Book = x.Book,
                                                                Instrument = x.Instrument,
                                                                ServerId = x.ServerId,
                                                                TimeStamp = x.TimeStamp
                                                                //Side = x.Side
                                                            }
                                                   )
                                    .Select(x => new QDFDealPosition()
                                                    {
                                                        PositionName = String.Format("{0} {1} {2} {3}",x.Key.Book , x.Key.Instrument , x.Key.ServerId , x.Key.TimeStamp.ConvertDateTimeToMySqlDateFormatToSeconds()),
                                                        Book = x.Key.Book,
                                                        Instrument = x.Key.Instrument,
                                                        ServerId = x.Key.ServerId,
                                                        TimeStamp = x.Key.TimeStamp,
                                                        QDFDeals = x.ToList()
                                                    }
                                                ).ToList<QDFDealPosition>();

            foreach (var position in aggregatedDeals)
            {
                position.CalculatePosition();
                Console.WriteLine("QDF position {0} contains {1} deals and has a value of {2}", position.PositionName, position.QDFDeals.Count.ToString(), position.Position.ToString());
            }
            QDFDealPositions = aggregatedDeals;
        }

        public void AggregateCCToolData()
        {
            CalculateCCVolumeSize();
            CombineCCSectionData();
        }

        private void CombineCCSectionData()
        {
            var rowQuery = (from DataRow row in CCToolData.Rows
                            select row);
            var aggregatedPositions = rowQuery.GroupBy(x => new
                                                            {
                                                                Book = ((ulong)x["IsBookA"] == 0 ? Book.A : Book.B),
                                                                Instrument = x["SymbolCode"].ToString(),
                                                                ServerId = x["ServerName"].ToString(),
                                                                TimeStamp = (DateTime) x["UpdateDateTime"] 
                                                            }
                                                        )
                                                        .Select(x => new CCToolPosition()
                                                        {
                                                            PositionName = String.Format("{0} {1} {2} {3}", x.Key.Book, x.Key.Instrument, x.Key.ServerId, Convert.ToDateTime(x.Key.TimeStamp).ToString(DateTimeUtils.MySqlDateFormatToSeconds)),
                                                            Book = x.Key.Book,
                                                            Instrument = x.Key.Instrument,
                                                            ServerId = x.Key.ServerId,
                                                            TimeStamp = x.Key.TimeStamp,
                                                            Positions = x.ToList()
                                                        }).ToList<CCToolPosition>();
            foreach (CCToolPosition position in aggregatedPositions)
            {
                position.CalculatePosition();
                Console.WriteLine("CCTool position {0} contains {1} deals and has a value of {2}", position.PositionName, position.Positions.Count.ToString(), position.Position.ToString());
            }
            CCToolPositions = aggregatedPositions;
        }

        private void CalculateCCVolumeSize()
        {
            CCToolData.Columns.Add(new DataColumn("VolumeSize", typeof(decimal)));

            #region nice little demo of not using deferred execution
            //works ok, but dow we really need to double query the rows?
            //List<CCtoolRow> ccrowQuery = (from CCtoolRow row in CCToolData.Rows
            //                            select row).ToList<CCtoolRow>();
            //List<DataRow> rowQuery = (from DataRow row in CCToolData.Rows
            //                          select row).ToList<DataRow>();

            //for (int i = 0; i < ccrowQuery.Count(); i++)
            //{
            //    var VolumeSize = ccrowQuery[i].Volume * ccrowQuery[i].ContractSize;
            //    rowQuery[i]["VolumeSize"] = VolumeSize;
            //}

            //rowQuery = (from DataRow row in CCToolData.Rows
            //            select row).ToList<DataRow>();
            //foreach (DataRow row in rowQuery)
            //{
            //    Assert.AreEqual((decimal)row["VolumeSize"], (decimal)row["Volume"] * (decimal)row["ContractSize"]);
            //}
            #endregion

            var rowQuery = (from DataRow row in CCToolData.Rows
                            select row);
            foreach (var row in rowQuery)
            {
                row["VolumeSize"] = (decimal)row["Volume"] * (decimal)row["ContractSize"];
            }

            foreach (DataRow row in rowQuery)
            {
                Console.WriteLine("CC position {0} has a value of {1}",
                    GetCCToolPositionName(row), 
                    row["VolumeSize"]);
            }
        }

        private static string GetCCToolPositionName(DataRow row)
        {
            return String.Format("{0} {1} {2} {3}", row["IsBookA"].ToString(), row["SymbolCode"], row["ServerName"], Convert.ToDateTime(row["UpdateDateTime"]).ToString(DateTimeUtils.MySqlDateFormatToSeconds));
        }

        //check console output by dumping to excel, sorting and applying this formula =IF(CONCATENATE(C2,D2,E2,F2,G2)<>CONCATENATE(C1,D1,E1,F1,G1),"ok","dup")
    }

    public class QDFDealPosition
    {
        public string PositionName { get; set; }
        public Book Book { get; set; }

        public string Instrument { get; set; }

        public string ServerId { get; set; }

        //public Side Side { get; set; }

        public DateTime TimeStamp { get; set; }

        public List<Deal> QDFDeals { get; set; }

        public decimal Position { get; private set; }

        public void CalculatePosition()
        {
            QDFDeals.ForEach(delegate(Deal deal)
            {
                Position += deal.Volume * (deal.Side == Side.Buy ? 1 : -1);
            });
        }
    }

    public class CCToolPosition
    {
        public string PositionName { get; set; }
        public Book Book { get; set; }

        public string Instrument { get; set; }

        public string ServerId { get; set; }

        //public Side Side { get; set; }

        public DateTime TimeStamp { get; set; }

        public List<DataRow> Positions { get; set; }

        public decimal Position { get; private set; }

        public void CalculatePosition()
        {
            Positions.ForEach(delegate(DataRow position)
            {
                Position += (decimal) position["VolumeSize"];
            });
        }
    }

    //public class QDFDealPositionGrouping
    //{
    //    public Book Book { get; set; }

    //    public string Instrument { get; set; }

    //    public string ServerId { get; set; }

    //    //public Side Side { get; set; }

    //    // public DateTime TimeStamp { get; set; }

    //    // public List<Deal> QDFDeals { get; set; }

    //}


}
