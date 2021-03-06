﻿using System;
using System.Collections.Generic;
using System.Globalization;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
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
                    short side;
                    short state;
                    var deal = new TestableDeal
                    {
                        AccountGroup = row.Hub,
                        // may change to replicate ArsImporter logic of using firstname + lasrname from login table
                        BankPrice = (decimal) row.SpotRate,
                        //may change to  if(hub IS NULL, spotrate, spotratehubtomaker) as spotrate
                        ClientId = row.Login,
                        ClientPrice = (decimal) row.Price,
                        //note typo in Agressor...// and also the logical inconsistency in Aggressed!
                        Comment = row.Aggressor == 1 || row.Aggressor == 2
                            ? (row.Aggressor == 1 ? "Agressor:1" : "Agressor:2")
                            : row.Aggressor.ToString(CultureInfo.InvariantCulture),                       
                        //this is due to be changed to just be 1/2 so the datatype of this field may change to int
                        DealId = row.TradeId,
                        Instrument = String.Format("{0}{1}", row.TradedCcy, row.CounterCcy),
                        OrderId = row.OrderId,
                        Server = TradingServer.Currenex,
                        // Side is stored as 1/2 in aukcx hedge, and as 0/1 in redis
                        Side = Int16.TryParse(row.Side, out side)
                                ? (TestableSide) side.ParseEnum(typeof (TestableSide)) -1
                                : TestableSide.None,
                            //Int16.TryParse(row.Side, out side)
                            //    ? (TestableSide) side.ParseEnum(typeof (TestableSide))
                            //    : TestableSide.None,
                        State =
                            Int16.TryParse(row.TradeType.ToString(CultureInfo.InvariantCulture), out state)
                                ? (DealState) state.ParseEnum(typeof (DealState))
                                : DealState.OpenNormal,
                        TimeStamp = row.TransactTime,
                        Volume = (decimal) row.AmountCcy1
                    };
                    switch (row.Book.Trim().ToUpperInvariant())
                    {
                        case "B-BOOK":
                            deal.Book = Book.B;
                            break;
                        case "A-BOOK":
                            deal.Book = Book.A;
                            break;
                        default:
                            deal.Book = Book.None;
                            break;
                    }

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
                    var newDeal = new TestableDeal
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