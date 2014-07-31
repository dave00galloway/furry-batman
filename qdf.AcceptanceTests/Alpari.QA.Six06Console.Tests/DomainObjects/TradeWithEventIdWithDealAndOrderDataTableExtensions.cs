using System;
using System.Collections.Generic;
using System.Data;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.Six06Console.Tests.DomainObjects
{
    public static class TradeWithEventIdWithDealAndOrderDataTableExtensions
    {
        public static TradeWithEventIdWithDealAndOrderDataTable ConvertAllRowsInTradeWithEventIdDataTable(
            this TradeWithEventIdDataTable tradeWithEventIdDataTable,
            IEnumerable<KeyValuePair<int, OrderDealMapping>> orderDealMapping)
        {
            return
                tradeWithEventIdDataTable.ConvertTradeWithEventIdDataTable(orderDealMapping)
                    .MapRemainingTradesWithEventIds(tradeWithEventIdDataTable);
        }

        public static TradeWithEventIdWithDealAndOrderDataTable ConvertTradeWithEventIdDataTable(
            this TradeWithEventIdDataTable tradeWithEventIdDataTable,
            IEnumerable<KeyValuePair<int, OrderDealMapping>> orderDealMapping)
        {
            tradeWithEventIdDataTable.SetPrimaryKey(new[] {"OrderEventId"});
            var convertedTable = new TradeWithEventIdWithDealAndOrderDataTable("MT5Deals", new[] {"OrderEventId"});
            foreach (var dealMapping in orderDealMapping)
            {
                var row = tradeWithEventIdDataTable.Rows.Find(dealMapping.Key) as TradeWithEventIdDataTableRow;
                if (row != null)
                    convertedTable.Rows.Add(new object[]
                    {
                        row.OrderEventId,
                        row.OriginTimeStamp, //.Truncate(TimeSpan.FromSeconds(1)), //OriginTimeStamp =
                        row.FillVolume, // = FillVolume =
                        row.Price, //Price = 
                        row.Comment, //Comment = 
                        row.ExecId, //ExecID = 
                        row.Side, //Side = 
                        row.OrderTimeTypeId, //OrderTimeTypeID = 
                        row.OrderPriceTypeId, //OrderPriceTypeID =
                        row.TeMnemonic, //TEMnemonic = 
                        dealMapping.Value.Deal, //Deal = 
                        default(ulong), //Login = 
                        dealMapping.Value.Order //Order = 
                    })
                        ;
            }
            return convertedTable;
        }

        public static TradeWithEventIdWithDealAndOrderDataTable ConvertMt5DealsDataTable(
            this DealsDataTable tradeWithEventIdDataTable,
            IEnumerable<KeyValuePair<int, OrderDealMapping>> orderDealMapping)
        {
            //var deals = new List<IGetTradeswithEventIdResultWithDealAndOrder>();
            tradeWithEventIdDataTable.SetPrimaryKey(new[] {"Deal"});
            var convertedTable = new TradeWithEventIdWithDealAndOrderDataTable("MT5Deals", new[] {"OrderEventId"});
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
                        row.Symbol, //TEMnemonic = 
                        row.Deal, //Deal = 
                        row.Login, //Login = 
                        row.Order //Order = 
                    })
                        ;
            }
            return convertedTable;
        }

        private static TradeWithEventIdWithDealAndOrderDataTable MapRemainingTradesWithEventIds(
            this TradeWithEventIdWithDealAndOrderDataTable convertedTradesWithEventIds,
            TradeWithEventIdDataTable tradeWithEventIdDataTable)
        {
            tradeWithEventIdDataTable.SetPrimaryKey(new[] { "OrderEventId" });
            convertedTradesWithEventIds.SetPrimaryKey(new[] { "OrderEventId" });
            foreach (TradeWithEventIdDataTableRow row in tradeWithEventIdDataTable.Rows)
            {
                DataRow convertedRow = convertedTradesWithEventIds.Rows.Find(row.OrderEventId);
                if (convertedRow == null)
                {
                    convertedTradesWithEventIds.Rows.Add(new object[]
                    {
                        row.OrderEventId,
                        row.OriginTimeStamp, //.Truncate(TimeSpan.FromSeconds(1)), //OriginTimeStamp =
                        row.FillVolume, // = FillVolume =
                        row.Price, //Price = 
                        row.Comment, //Comment = 
                        row.ExecId, //ExecID = 
                        row.Side, //Side = 
                        row.OrderTimeTypeId, //OrderTimeTypeID = 
                        row.OrderPriceTypeId, //OrderPriceTypeID =
                        row.TeMnemonic, //TEMnemonic = 
                        default(ulong), //Deal = 
                        default(ulong), //Login = 
                        default(ulong) //Order = 
                    })
                        ;
                }
            }
            return convertedTradesWithEventIds;
        }
    }
}