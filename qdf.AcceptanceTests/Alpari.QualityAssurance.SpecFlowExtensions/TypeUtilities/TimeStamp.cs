using System;
using System.Runtime.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     an implementation of DateTime which has a default ToString which returns dd-MM-yyy HH:mm:ss.fff
    ///     TODO:- provide constructor overrides with string format, IFormatProvider formatProvider so that alternate string
    ///     formats can be returned from ToString()
    /// </summary>
    [SerializableAttribute]
    public struct TimeStamp : IComparable, IFormattable, IConvertible, ISerializable, IComparable<DateTime>,
        IEquatable<DateTime>
    {
        public const string DefaultToStringFormat = "dd/MM/yyy HH:mm:ss.fff";
        public readonly DateTime DateTime;
        private readonly string _toStringFormat;

        public string ToStringFormat
        {
            get { return _toStringFormat; }
           // private set { _toStringFormat = value; }
        }

        public TimeStamp(DateTime dateTime)
        {
            DateTime = dateTime;
            _toStringFormat = null;
        }

        public TimeStamp(DateTime dateTime, string toStringFormat)
        {
            DateTime = dateTime;
            _toStringFormat = toStringFormat;
        }

        public int CompareTo(object obj)
        {
            return ((IComparable) DateTime).CompareTo(obj);
        }

        public int CompareTo(DateTime other)
        {
            return DateTime.CompareTo(other);
        }

        public TypeCode GetTypeCode()
        {
            return ((IConvertible) DateTime).GetTypeCode();
        }

        public bool ToBoolean(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToBoolean(provider);
        }

        public char ToChar(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToChar(provider);
        }

        public sbyte ToSByte(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToSByte(provider);
        }

        public byte ToByte(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToByte(provider);
        }

        public short ToInt16(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToInt16(provider);
        }

        public ushort ToUInt16(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToUInt16(provider);
        }

        public int ToInt32(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToInt32(provider);
        }

        public uint ToUInt32(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToUInt32(provider);
        }

        public long ToInt64(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToInt64(provider);
        }

        public ulong ToUInt64(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToUInt64(provider);
        }

        public float ToSingle(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToSingle(provider);
        }

        public double ToDouble(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToDouble(provider);
        }

        public decimal ToDecimal(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToDecimal(provider);
        }

        public DateTime ToDateTime(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToDateTime(provider);
        }

        public string ToString(IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToString(provider);
        }

        public object ToType(Type conversionType, IFormatProvider provider)
        {
            return ((IConvertible) DateTime).ToType(conversionType, provider);
        }

        public bool Equals(DateTime other)
        {
            return DateTime.Equals(other);
        }

        public string ToString(string format, IFormatProvider formatProvider)
        {
            return ((IFormattable) DateTime).ToString(format, formatProvider);
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            ((ISerializable) DateTime).GetObjectData(info, context);
        }

        /// <summary>
        ///     TODO:- detect if a constructor overload specified a string format and/or format provider
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return _toStringFormat == null
                ? DateTime.ToString(DefaultToStringFormat)
                : DateTime.ToString(_toStringFormat);
        }
    }
}