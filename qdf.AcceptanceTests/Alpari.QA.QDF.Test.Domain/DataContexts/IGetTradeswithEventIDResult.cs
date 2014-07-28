using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;

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

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_OrderEventID", DbType = "Int NOT NULL")]
        int OrderEventID { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_OriginTimeStamp", DbType = "DateTime")]
        System.Nullable<System.DateTime> OriginTimeStamp { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_FillVolume", DbType = "Int")]
        System.Nullable<int> FillVolume { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_Price", DbType = "Float")]
        System.Nullable<double> Price { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_Comment", DbType = "VarChar(3000)")]
        string Comment { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_ExecID", DbType = "VarChar(255)")]
        string ExecID { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_Side", DbType = "Int NOT NULL")]
        int Side { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_OrderTimeTypeID", DbType = "Char(1)")]
        System.Nullable<char> OrderTimeTypeID { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_OrderPriceTypeID", DbType = "Char(1) NOT NULL")]
        char OrderPriceTypeID { get; set; }

        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_TEMnemonic", DbType = "VarChar(512) NOT NULL", CanBeNull = false)]
        string TEMnemonic { get; set; }
    }

    public partial class GetAutoTradeswithEventIDResult : IGetTradeswithEventIdResult
    {

    }

    public partial class GetManualTradeswithEventIDResult : IGetTradeswithEventIdResult
    {

    }

    /// <summary>
    /// Since all the stored procs in GetTradeswithEventIDDataContextDataContext return the same data structure (IGetTradeswithEventIdResult)
    /// They can all be mapped to each other. Using this one "GetTradeswithEventIDResult" as the default
    /// </summary>
    public partial class GetTradeswithEventIDResult : IGetTradeswithEventIdResult
    {

    }

    public partial class GetTradeswithEventIDDataContext
    {
        public IList<T> GetAutoTradeswithEventID<T>([Parameter(DbType = "Int")] Nullable<int> lasteventidprocessed)
            where T : IGetTradeswithEventIdResult, new()
        {
            var result = GetAutoTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface<T>(result);
        }

        public IList<T> GetManualTradeswithEventID<T>([global::System.Data.Linq.Mapping.ParameterAttribute(DbType = "Int")] System.Nullable<int> lasteventidprocessed) where T : IGetTradeswithEventIdResult, new()
        {
            var result = GetManualTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface<T>(result);
        }

        public IList<T> GetTradeswithEventID<T>([global::System.Data.Linq.Mapping.ParameterAttribute(DbType = "Int")] System.Nullable<int> lasteventidprocessed) where T : IGetTradeswithEventIdResult, new()
        {
            var result = GetTradeswithEventID(lasteventidprocessed);
            return MapProcReturnTypeToGenericInterface<T>(result);
        }

        private static IList<T> MapProcReturnTypeToGenericInterface<T>(IEnumerable<IGetTradeswithEventIdResult> result) where T : IGetTradeswithEventIdResult, new()
        {
            return (from IGetTradeswithEventIdResult eventIdResult in result
                    select new T
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
                    }).ToList();
        }
    }
    // ReSharper restore PossibleNullReferenceException
    // ReSharper restore AccessToStaticMemberViaDerivedType
    // ReSharper restore ConvertNullableToShortForm
    // ReSharper restore InconsistentNaming
    // ReSharper restore RedundantNameQualifier
#pragma warning restore 1591
}