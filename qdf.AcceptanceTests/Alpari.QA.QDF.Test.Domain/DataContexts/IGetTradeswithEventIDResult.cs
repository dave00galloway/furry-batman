using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;

#pragma warning disable 1591
// ReSharper disable RedundantNameQualifier
// ReSharper disable InconsistentNaming
// ReSharper disable ConvertNullableToShortForm
// ReSharper disable AccessToStaticMemberViaDerivedType
// ReSharper disable PossibleNullReferenceException

namespace Alpari.QA.QDF.Test.Domain.DataContexts
{
    public interface IGetTradeswithEventIdResult
    {
        [Column(Storage = "_OrderEventID", DbType = "Int NOT NULL")]
        int OrderEventID { get; set; }

        [Column(Storage = "_OriginTimeStamp", DbType = "DateTime")]
        Nullable<DateTime> OriginTimeStamp { get; set; }

        [Column(Storage = "_FillVolume", DbType = "Float")]
        Nullable<double> FillVolume { get; set; }

        [Column(Storage = "_Price", DbType = "Float")]
        Nullable<double> Price { get; set; }

        [Column(Storage = "_Comment", DbType = "VarChar(3000)")]
        string Comment { get; set; }

        [Column(Storage = "_ExecID", DbType = "VarChar(255)")]
        string ExecID { get; set; }

        [Column(Storage = "_Side", DbType = "Int NOT NULL")]
        int Side { get; set; }

        [Column(Storage = "_OrderTimeTypeID", DbType = "Char(1)")]
        Nullable<char> OrderTimeTypeID { get; set; }

        [Column(Storage = "_OrderPriceTypeID", DbType = "Char(1) NOT NULL")]
        char OrderPriceTypeID { get; set; }

        [Column(Storage = "_TEMnemonic", DbType = "VarChar(512) NOT NULL", CanBeNull = false)]
        string TEMnemonic { get; set; }
    }

    public interface IGetTradeswithEventIdResultWithDealAndOrder : IGetTradeswithEventIdResult
    {
        ulong Deal { get; set; }
        ulong Login { get; set; }
        ulong Order { get; set; }
    }

    public partial class GetAutoTradeswithEventIDResult : IGetTradeswithEventIdResult
    {
    }

    public partial class GetManualTradeswithEventIDResult : IGetTradeswithEventIdResult
    {
    }

    /// <summary>
    ///     Since all the stored procs in GetTradeswithEventIDDataContextDataContext return the same data structure
    ///     (IGetTradeswithEventIdResult)
    ///     They can all be mapped to each other. Using this one "GetTradeswithEventIDResult" as the default
    /// </summary>
    public partial class GetTradeswithEventIDResult : IGetTradeswithEventIdResult
    {
    }

    public class GetTradeswithEventIDResultWithDealAndOrder : GetTradeswithEventIDResult,
        IGetTradeswithEventIdResultWithDealAndOrder
    {
        public ulong Deal { get; set; }
        public ulong Login { get; set; }
        public ulong Order { get; set; }
    }

    public partial class GetTradeswithEventIDDataContext
    {
        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T">Unused, except to distinguish between this overload and the wizard generated one</typeparam>
        /// <param name="lasteventidprocessed"></param>
        /// <returns></returns>
        public IList<IGetTradeswithEventIdResult> GetAutoTradeswithEventID<T>(
            [Parameter(DbType = "Int")] Nullable<int> lasteventidprocessed)
            where T : IGetTradeswithEventIdResult //, new()
        {
            var result = GetAutoTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface(result);
        }

        public IList<IGetTradeswithEventIdResult> GetManualTradeswithEventID<T>(
            [Parameter(DbType = "Int")] Nullable<int> lasteventidprocessed)
            where T : IGetTradeswithEventIdResult //, new()
        {
            var result = GetManualTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface(result);
        }

        public IList<IGetTradeswithEventIdResult> GetTradeswithEventID<T>(
            [Parameter(DbType = "Int")] Nullable<int> lasteventidprocessed)
            where T : IGetTradeswithEventIdResult //, new()
        {
            var result = GetTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface(result);
        }

        private static IList<IGetTradeswithEventIdResult> MapProcReturnTypeToGenericInterface(
            IEnumerable<IGetTradeswithEventIdResult> result) //, new()
        {
            return result.Select(eventIdResult => new GetTradeswithEventIDResult
            {
                Comment = eventIdResult.Comment,
                ExecID = eventIdResult.ExecID,
                FillVolume = eventIdResult.FillVolume,
                OrderEventID = eventIdResult.OrderEventID,
                OrderPriceTypeID = eventIdResult.OrderPriceTypeID,
                OrderTimeTypeID = eventIdResult.OrderTimeTypeID,
                OriginTimeStamp = eventIdResult.OriginTimeStamp,
                Price = eventIdResult.Price,
                Side = eventIdResult.Side,
                TEMnemonic = eventIdResult.TEMnemonic
            }).Cast<IGetTradeswithEventIdResult>().ToList();
        }
    }

    // ReSharper restore PossibleNullReferenceException
    // ReSharper restore AccessToStaticMemberViaDerivedType
    // ReSharper restore ConvertNullableToShortForm
    // ReSharper restore InconsistentNaming
    // ReSharper restore RedundantNameQualifier
#pragma warning restore 1591
}