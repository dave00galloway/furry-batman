using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables
{
    public static class TradeWithEventIdDataTableExtensions
    {
        public static List<GetTradeswithEventIDResult> ConvertToTradeEventWithIds(this IEnumerable<Deal> retrievedDeals)
        {
            var tradeEventWithIdList = new List<GetTradeswithEventIDResult>();
            foreach (Deal deal in retrievedDeals)
            {
                try
                {
                    var newTradeEventWithId = new GetTradeswithEventIDResult
                    {
                        Comment = deal.Comment, //pretty sure this won't match up!
                        ExecID = deal.DealId,
                        FillVolume = (int?) deal.Volume,
                        OrderEventID = default(int), //won't have access to this
                        OrderPriceTypeID = 'C',
                        OrderTimeTypeID = '1', //always  GOOD_TILL_CANCEL
                        OriginTimeStamp = deal.TimeStamp,
                        Price = (double?) deal.ClientPrice,
                        Side = (int) (deal.Side.ToString().Parse<TestableSide>() ?? TestableSide.None),
                        TEMnemonic = deal.Instrument
                    };
                    tradeEventWithIdList.Add(newTradeEventWithId);
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger(String.Format("error processing deal {0}", deal.DealId));
                }
            }
            return tradeEventWithIdList;
        }
    }
}
