using System;
using System.Collections.Generic;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables
{
    public static class CnxTradeDataTableExtensions
    {
        public static IEnumerable<TestableDeal> MapCnxTradeDealsToQdfDeals(this CnxTradeDataTable table)
        {
            var dealList = new List<TestableDeal>();
            foreach (CnxTradeDataTableRow row in table.Rows)
            {
                try
                {
                    var deal = new TestableDeal
                    {
                        AccountGroup = row.Hub,
                        // may change to replicate ArsImporter logic of using firstname + lasrname from login table
                        BankPrice = (decimal) row.SpotRate,
                        //may change to  if(hub IS NULL, spotrate, spotratehubtomaker) as spotrate
                        Book = row.Book.Parse<Book>() ?? Book.None,
                        ClientId = row.Login,
                        ClientPrice = (decimal) row.Price,
                        Comment = row.Aggressor ? "Agressor:1" : "Aggressed:2", //note typo in Agressor...
                        //this is due to be changed to just be 1/2 so the datatype of this field may change to int
                        DealId = row.TradeId,
                        Instrument = String.Format("{0}{1}", row.TradedCcy, row.CounterCcy),
                        OrderId = row.OrderId,
                        Server = TradingServer.Currenex,
                        Side = row.Side.Parse<TestableSide>() ?? TestableSide.None,
                        State = row.TradeType.ToString().Parse<DealState>() ?? DealState.OpenNormal,
                        //datatype of table field may change from bool to int after fixes are applied
                        TimeStamp = row.TransactTime,
                        Volume = (decimal) row.AmountCcy1
                    };
                    dealList.Add(deal);
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger(String.Format("error processing deal {0}", row.TradeId));
                }
            }

            return dealList;
        }

        public static IEnumerable<TestableDeal> ConvertToTestableDeals(this IEnumerable<Deal> deals)
        {
            var dealList = new List<TestableDeal>();
            foreach (Deal deal in deals)
            {
                try
                {
                    var newDeal = new TestableDeal()
                    {
                        AccountGroup = deal.AccountGroup,
                        BankPrice = deal.BankPrice,
                        Book = deal.Book,
                        ClientId = deal.ClientId,
                        ClientPrice = deal.ClientPrice,
                        Comment = deal.Comment,
                        DealId = deal.DealId,
                        Instrument = deal.Instrument,
                        OrderId = deal.OrderId,
                        Server = deal.Server,
                        Side = deal.Side.ToString().Parse<TestableSide>() ?? TestableSide.None,
                        State = deal.State,
                        TimeStamp = deal.TimeStamp,
                        Volume = deal.Volume
                    };
                    dealList.Add(newDeal);
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger(String.Format("error processing deal {0}", deal.DealId));
                }
            }
            return dealList;
        }
    }
}