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
        private const string DEFAULT_TO_STRING_FORMAT = "dd/MM/yyy HH:mm:ss.fff";
        private readonly DateTime _dateTime;

        public TimeStamp(DateTime dateTime)
        {
            _dateTime = dateTime;
        }

        public int CompareTo(object obj)
        {
            return ((IComparable) _dateTime).CompareTo(obj);
        }

        public int CompareTo(DateTime other)
        {
            return _dateTime.CompareTo(other);
        }

        public TypeCode GetTypeCode()
        {
            return ((IConvertible) _dateTime).GetTypeCode();
        }

        public bool ToBoolean(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToBoolean(provider);
        }

        public char ToChar(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToChar(provider);
        }

        public sbyte ToSByte(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToSByte(provider);
        }

        public byte ToByte(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToByte(provider);
        }

        public short ToInt16(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToInt16(provider);
        }

        public ushort ToUInt16(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToUInt16(provider);
        }

        public int ToInt32(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToInt32(provider);
        }

        public uint ToUInt32(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToUInt32(provider);
        }

        public long ToInt64(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToInt64(provider);
        }

        public ulong ToUInt64(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToUInt64(provider);
        }

        public float ToSingle(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToSingle(provider);
        }

        public double ToDouble(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToDouble(provider);
        }

        public decimal ToDecimal(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToDecimal(provider);
        }

        public DateTime ToDateTime(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToDateTime(provider);
        }

        public string ToString(IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToString(provider);
        }

        public object ToType(Type conversionType, IFormatProvider provider)
        {
            return ((IConvertible) _dateTime).ToType(conversionType, provider);
        }

        public bool Equals(DateTime other)
        {
            return _dateTime.Equals(other);
        }

        public string ToString(string format, IFormatProvider formatProvider)
        {
            return ((IFormattable) _dateTime).ToString(format, formatProvider);
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            ((ISerializable) _dateTime).GetObjectData(info, context);
        }

        /// <summary>
        ///     TODO:- detect if a constructor overload specified a string format and/or format provider
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return _dateTime.ToString(DEFAULT_TO_STRING_FORMAT);
        }
    }
}