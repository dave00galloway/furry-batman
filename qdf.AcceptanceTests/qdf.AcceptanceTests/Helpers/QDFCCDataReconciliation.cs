using Alpari.QDF.Domain;
using NUnit.Framework;
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
                                                                ServerId = x.ServerId//,
                                                                //Side = x.Side
                                                            }
                                                   )
                                    .Select(x => new QDFDealPosition()
                                                    {
                                                        PositionName = x.Key.Book + x.Key.Instrument + x.Key.ServerId,
                                                        Book = x.Key.Book,
                                                        Instrument = x.Key.Instrument,
                                                        ServerId = x.Key.ServerId,
                                                        //Side = x.Key.Side,
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
                row["VolumeSize"] = (decimal)row["Volume"] * (decimal) row["ContractSize"]; 
            }

            foreach (DataRow row in rowQuery)
            {
               // Assert.AreEqual((decimal)row["VolumeSize"], (decimal)row["Volume"] * (decimal)row["ContractSize"]);
                Console.WriteLine("CC position {0} has a value of {1}", (row["IsBookA"].ToString() + row["SymbolCode"] + row["ServerName"]).Replace(" ", ""), row["VolumeSize"]);
            }            
        }
    }

    public class QDFDealPosition
    {
        public string PositionName { get; set; }
        public Book Book { get; set; }

        public string Instrument { get; set; }

        public string ServerId { get; set; }

        //public Side Side { get; set; }

        // public DateTime TimeStamp { get; set; }

        public List<Deal> QDFDeals { get; set; }

        public decimal Position { get; private set; }

        public void CalculatePosition()
        {
            QDFDeals.ForEach(delegate(Deal deal)
            {
                Position += deal.Volume * (int)deal.Side;
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
