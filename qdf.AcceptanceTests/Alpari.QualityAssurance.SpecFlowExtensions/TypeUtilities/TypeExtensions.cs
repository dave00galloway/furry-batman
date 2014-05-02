﻿using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     Methods for finding info about types
    /// </summary>
    public static class TypeExtensions
    {
        //TODO:- datetime
        public const string Byte = "BYTE"; //	0 .. 255
        public const string Sbyte = "SBYTE"; //	-128 .. 127
        public const string Short = "SHORT"; //	-32,768 .. 32,767
        public const string Ushort = "USHORT"; //	0 .. 65,535
        public const string Int = "INT"; //	-2,147,483,648 .. 2,147,483,647
        public const string Uint = "UINT"; //	0 .. 4,294,967,295
        public const string Long = "LONG"; //	-9,223,372,036,854,775,808 .. 9,223,372,036,854,775,807
        public const string Ulong = "ULONG"; //	0 .. 18,446,744,073,709,551,615
        public const string Float = "FLOAT"; //	-3.402823e38 .. 3.402823e38
        public const string Double = "DOUBLE"; //	-1.79769313486232e308 .. 1.79769313486232e308
        public const string Decimal = "DECIMAL"; //	-79228162514264337593543950335 .. 79228162514264337593543950335
        public const string Char = "CHAR"; //	A Unicode character.
        public const string String = "STRING"; //	A string of Unicode characters.
        public const string Bool = "BOOL"; //	True or False.
        public const string Object = "OBJECT"; //	An object.

        /// <summary>
        ///     Get a list of all the names of properties of a Type
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static List<string> GetPropertyNamesAsList(this Type type)
        {
            return type.GetProperties().Select(x => x.Name).ToList();
        }

        /// <summary>
        ///     Get a list of all the names of properties of a Type
        /// </summary>
        /// <param name="type"></param>
        /// <param name="safeMode"></param>
        /// <returns></returns>
        public static List<string> GetPropertyNamesAsList(this Type type, bool safeMode)
        {
            return safeMode ? type.GetProperties().Select(Name).ToList() : GetPropertyNamesAsList(type);
        }

        private static string Name(PropertyInfo x)
        {
            try
            {
                return x.Name;
            }
            catch (Exception e)
            {
                ConsoleLogger.ConsoleExceptionLogger(e);
                return Path.GetRandomFileName().Replace(".", "");
            }
        }

        /// <summary>
        /// use this method to get a list of property values when you are confident that the actual instantiated objects will have the properties expected of its type
        /// use the overload GetObjectPropertyValuesAsList(this object objectToSearch,IEnumerable string  propertyList) when you suspect the object defiiton may have changed
        /// </summary>
        /// <param name="objectToSearch"></param>
        /// <returns></returns>
        public static List<string> GetObjectPropertyValuesAsList(this object objectToSearch)
        {
            return objectToSearch.GetType().GetProperties().Select(x => x.GetValue(objectToSearch).ToString()).ToList();
        }

        /// <summary>
        /// use this overload if you suspect an object's defeinition may be out of date
        /// </summary>
        /// <param name="objectToSearch"></param>
        /// <param name="propertyList"></param>
        /// <returns></returns>
        public static List<string> GetObjectPropertyValuesAsList(this object objectToSearch,IEnumerable<string> propertyList)
        {
            //return GetProperties(objectToSearch,propertyList).Select(x => GetValue(objectToSearch,x).ToString()).ToList();
            return GetProperties(objectToSearch, propertyList).Select(x=> x.GetValue(objectToSearch).ToSafeString()).ToList();
        }

        private static PropertyInfo[] GetProperties(object objectToSearch, IEnumerable<string> propertyList)
        {
            var enumerable = propertyList as IList<string> ?? propertyList.ToList();
            PropertyInfo[] propertyInfo = new PropertyInfo[enumerable.Count()];
            for (int i = 0; i < enumerable.Count; i++)
            {
                var prop = enumerable[i];
                try
                {
                    propertyInfo[i] = objectToSearch.GetType().GetProperty(prop);
                }
                catch (Exception e)
                {
                    ConsoleLogger.ConsoleExceptionLogger(e);
                    propertyInfo[i] = null;
                }
            }
            return propertyInfo;
        }

        public static object GetValue(object objectToSearch, PropertyInfo x)
        {
            try
            {
                var defValtype = x.PropertyType.GetDataType();
            return GetdefaultValueFortype(objectToSearch, x, defValtype);
            }
            catch (Exception e)
            {
                ConsoleLogger.ConsoleExceptionLogger(e);
                return Path.GetRandomFileName().Replace(".", "");
            }
        }

        public static object GetdefaultValueFortype(object objectToSearch, PropertyInfo x, string defValtype)
        {
            switch (defValtype.ToUpper())
            {
                case Byte:
                    return x.GetValue(objectToSearch) ?? default(byte);
                case Sbyte:
                    return x.GetValue(objectToSearch) ?? default(sbyte);
                case Short:
                    return x.GetValue(objectToSearch) ?? default(short);
                case Ushort:
                    return x.GetValue(objectToSearch) ?? default(ushort);
                case Int:
                    return x.GetValue(objectToSearch) ?? default(int);
                case "INT16":
                    return x.GetValue(objectToSearch) ?? default(Int16);
                case "INT32":
                    return x.GetValue(objectToSearch) ?? default(Int32);
                case "INT64":
                    return x.GetValue(objectToSearch) ?? default(Int64);
                case Uint:
                    return x.GetValue(objectToSearch) ?? default(uint);
                case "UINT16":
                    return x.GetValue(objectToSearch) ?? default(UInt16);
                case "UINT32":
                    return x.GetValue(objectToSearch) ?? default(UInt32);
                case "UINT64":
                    return x.GetValue(objectToSearch) ?? default(UInt64);
                case Long:
                    return x.GetValue(objectToSearch) ?? default(long);
                case Ulong:
                    return x.GetValue(objectToSearch) ?? default(ulong);
                case Float:
                    return x.GetValue(objectToSearch) ?? default(float);
                case Double:
                    return x.GetValue(objectToSearch) ?? default(double);
                case Decimal:
                    return x.GetValue(objectToSearch) ?? default(Decimal);
                case Char:
                    return x.GetValue(objectToSearch) ?? default(char);
                case String:
                    return x.GetValue(objectToSearch) ?? String.Empty;
                case Bool:
                    return x.GetValue(objectToSearch) ?? default(bool);
                default:
                    return new object();
            }
        }


        public static bool IsNumber(this string s)
        {
            float output;
            return float.TryParse(s, out output);
        }

        public static string GetDataType(this Type type)
        {
            string typeShortName = type.FullName.Split('.')[type.FullName.Split('.').Length - 1];
            return typeShortName;
        }
    }
}