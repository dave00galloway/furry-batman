using Alpari.QDF.Domain;
using qdf.AcceptanceTests.TypedDataTables;
using System;
using System.Collections.Generic;
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
                Console.WriteLine("position {0} contains {1} deals and has a value of {2}", position.PositionName, position.QDFDeals.Count.ToString(), position.Position.ToString());
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
