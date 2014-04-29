using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

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
            return safeMode ? GetPropertyNamesAsList(type) : type.GetProperties().Select(Name).ToList();
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
            return GetProperties(objectToSearch,propertyList).Select(x => GetValue(objectToSearch,x).ToString()).ToList();
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

        private static object GetValue(object objectToSearch, PropertyInfo x)
        {
            try
            {
                var value = x.GetValue(objectToSearch)??"";
                return value;
            }
            catch (Exception e)
            {
                ConsoleLogger.ConsoleExceptionLogger(e);
                return Path.GetRandomFileName().Replace(".", "");
            }
        }

        public static bool IsNumber(this string s)
        {
            float output;
            return float.TryParse(s, out output);
        }

        //public static List<string> GetPropertyNamesAsList<T>()
        //{
        //    return T.GetProperties().Select(x => x.Name).ToList();
        //}

        public static string GetDataType(this Type type)
        {
            string typeShortName = type.FullName.Split('.')[type.FullName.Split('.').Length - 1];
            return typeShortName;
        }
    }
}