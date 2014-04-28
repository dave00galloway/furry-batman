using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;

namespace Alpari.QualityAssurance.SecureMyPassword
{
    public static class DataProtectionSample
    {
        // Create byte array for additional entropy when using Protect method. 
        // private static byte[] s_aditionalEntropy = {9, 4, 7, 3, 5};

        public static byte[] Protect(this byte[] data)
        {
            try
            {
                // Encrypt the data using DataProtectionScope.CurrentUser. The result can be decrypted 
                //  only by the same current user. 
                return ProtectedData.Protect(data, null, DataProtectionScope.CurrentUser);
            }
            catch (CryptographicException e)
            {
                Console.WriteLine("Data was not encrypted. An error occurred.");
                Console.WriteLine(e.ToString());
                return null;
            }
        }

        public static string Protect(this string data, string seperator)
        {
            return data.ConvertStringToByteArray().Protect().ByteArrayToString(seperator);
        }

        public static byte[] Unprotect(this byte[] data)
        {
            try
            {
                //Decrypt the data using DataProtectionScope.CurrentUser. 
                return ProtectedData.Unprotect(data, null, DataProtectionScope.CurrentUser);
            }
            catch (CryptographicException e)
            {
                Console.WriteLine("Data was not decrypted. An error occurred.");
                Console.WriteLine(e.ToString());
                return null;
            }
        }

        public static string UnProtect(this string data, char seperator)
        {
            return data.StringToByteArray(seperator).Unprotect().CharByteArrayToString();
        }

        public static byte[] ConvertStringToByteArray(this string stringToConvert)
        {
            var query = stringToConvert.ToArray().Select(Convert.ToByte);
            return query.ToArray();
        }

        public static string ByteArrayToString(this byte[] data, string separator)
        {
            string byteArrayAsString = null;
            // returns unprintable charactes and quouation marks which would be a pain to work around
            // var stringQuery = data.Select(x => Convert.ToChar(x)).Select(x=>byteArrayAsString+=x.ToString()).ToList();
            byteArrayAsString = String.Join(separator, data.Select(x => x.ToString(CultureInfo.InvariantCulture)).ToArray());
            //
            return byteArrayAsString;
        }

        public static string CharByteArrayToString(this byte[] data)
        {
            string byteArrayAsString = null;
            var stringQuery =
                data.Select(x => Convert.ToChar(x)).Select(x => byteArrayAsString += x.ToString(CultureInfo.InvariantCulture)).ToList();
            // byteArrayAsString = String.Join(separator, data.Select(x => x.ToString()).ToArray());
            //
            return byteArrayAsString;
        }

        public static byte[] StringToByteArray(this string data, char separator)
        {
            // returns unprintable charactes and quouation marks which would be a pain to work around
            // var stringQuery = data.Select(x => Convert.ToChar(x)).Select(x=>byteArrayAsString+=x.ToString()).ToList();
            var byteArray = data.Split(separator).Select(x => Convert.ToByte(x)).ToArray();
            //

            return byteArray;
        }

        public static void PrintValues(this Byte[] myArr)
        {
            foreach (var i in myArr)
            {
                Console.Write("\t{0}", i);
            }
            Console.WriteLine();
        }
    }
}