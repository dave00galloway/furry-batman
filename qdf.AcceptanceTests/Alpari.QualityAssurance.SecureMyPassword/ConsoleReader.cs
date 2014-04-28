using System;
using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.SecureMyPassword
{
    public static class ConsoleReader
    {
        public static byte[] GetPasswordAsByteArray()
        {
            Console.Write("Enter password: ");
            ConsoleKeyInfo key;
            var keys = new List<char>();
            do
            {
                key = Console.ReadKey(true);

                //// Ignore any key out of range. 
                //if (((int)key.Key) >= 65 && ((int)key.Key <= 90))
                //{
                // Append the character to the password.
                //securePwd.AppendChar(key.KeyChar);
                keys.Add(key.KeyChar);
                Console.Write("*");
                //}
                // Exit if Enter key is pressed.
            } while (key.Key != ConsoleKey.Enter);
            Console.WriteLine("done");
            var query = keys.Select(x => Convert.ToByte(x));
            return query.ToArray();
        }
    }
}