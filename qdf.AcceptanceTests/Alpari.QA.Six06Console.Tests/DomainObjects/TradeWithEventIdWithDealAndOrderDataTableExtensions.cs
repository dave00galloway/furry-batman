using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.Six06Console.Tests.DomainObjects
{
    public static class TradeWithEventIdWithDealAndOrderDataTableExtensions
    {
        public static TradeWithEventIdWithDealAndOrderDataTable ConvertTradeWithEventIdDataTable(
            this TradeWithEventIdDataTable tradeWithEventIdDataTable)
        {
            return tradeWithEventIdDataTable.ConvertToTypedDataTable<TradeWithEventIdWithDealAndOrderDataTable>();
        }

        public static TradeWithEventIdWithDealAndOrderDataTable ConvertMt5DealsDataTable(
            this DealsDataTable tradeWithEventIdDataTable, IEnumerable<KeyValuePair<int, OrderDealMapping>> orderDealMapping)
        {
            //var deals = new List<IGetTradeswithEventIdResultWithDealAndOrder>();
            tradeWithEventIdDataTable.SetPrimaryKey(new []{"Deal"});
            var convertedTable = new TradeWithEventIdWithDealAndOrderDataTable("MT5Deals", new[] {"Deal"});
            foreach (var dealMapping in orderDealMapping)
            {
                var row = tradeWithEventIdDataTable.Rows.Find(dealMapping.Value.Deal) as DealsDataRow;
                if (row != null)
                    convertedTable.Rows.Add(new object[]
                {
                    dealMapping.Key, //OrderEventID =
                    row.TimeStamp.Truncate(TimeSpan.FromSeconds(1)), //OriginTimeStamp =
                    row.Volume, // = FillVolume =
                    (double?) row.Price, //Price = 
                    row.Comment, //Comment = 
                    "", //ExecID = 
                    (int) row.Action, //Side = 
                    default(char), //OrderTimeTypeID = 
                    default(char), //OrderPriceTypeID =
                    row.Symbol,                    //TEMnemonic = 
                    row.Deal, //Deal = 
                    row.Login, //Login = 
                    row.Order //Order = 
                })
                ;
                //var deal = new GetTradeswithEventIDResultWithDealAndOrder
                //{
                //    Comment = row.Comment,
                //    Deal = row.Deal,
                //    ExecID = "",
                //    FillVolume = row.Volume,
                //    Login = row.Login,
                //    Order = row.Order,
                //    OrderEventID = dealMapping.Key,
                //    OrderPriceTypeID = default(char),
                //    OrderTimeTypeID = default(char),
                //    OriginTimeStamp = row.TimeStamp,
                //    Price = (double?) row.Price,
                //    Side = (int) row.Action,
                //    TEMnemonic = row.Symbol
                //});
            }
//            var convertedTable = new TradeWithEventIdWithDealAndOrderDataTable();//.ConvertIEnumerableToDataTable(deals);//tradeWithEventIdDataTable.ConvertToTypedDataTable<TradeWithEventIdWithDealAndOrderDataTable>();
            //foreach (DealsDataRow row in tradeWithEventIdDataTable.Rows)
            //{
                
            //}
            return convertedTable;
        }
    }
}
