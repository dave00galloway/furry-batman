using System;
using System.Collections.Generic;
using System.Reflection;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    public static class CnxTradeActivityExtensions
    {
        public static IEnumerable<TestableDeal> MapCnxTradeActivityToTestableDeals(
            this IEnumerable<CnxTradeActivity> cnxTradeActivities)
        {
            var testableDeals = new List<TestableDeal>();

            foreach (CnxTradeActivity cnxTradeActivity in cnxTradeActivities)
            {
                var side = TestableSide.None;
                var deal = new TestableDeal
                {
                    AccountGroup = "",
                    BankPrice = cnxTradeActivity.Rate,
                    Book = Book.None,
                    ClientId = cnxTradeActivity.Taker,
                    ClientPrice = cnxTradeActivity.Rate,
                    Comment = cnxTradeActivity.Comments,
                    DealId = cnxTradeActivity.TradeId,
                    Instrument = cnxTradeActivity.CurrencyPair.Replace("/", ""),
                    OrderId = "",
                    Server = TradingServer.Currenex,
                    TimeStamp = cnxTradeActivity.TradeDateGMT,
                    Volume = cnxTradeActivity.Amount
                };
                //Note to self - don't declare properties on subclasses that have the same name and a differnt type when you don't have control of the original class to mark the property as virtual!
                var sideValue = Enum.TryParse(cnxTradeActivity.BuySell,true, out side) ? side : TestableSide.None;
                var prop = typeof(TestableDeal).GetProperty("Side", BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);
                deal.SetValue(prop, sideValue);
                testableDeals.Add(deal);
            }
            

            return testableDeals;
        }
    }
}