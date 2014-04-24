using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SecureMyPassword
{
    /// <summary>
    /// uses a combination of techniques found from 
    /// http://msdn.microsoft.com/en-us/library/system.security.securestring.aspx
    /// and
    /// http://msdn.microsoft.com/en-us/library/system.security.cryptography.protecteddata.aspx
    /// to create a password 
    /// </summary>
    public class Program
    {
        public static void Main(string[] args)
        {
            var toEncrypt = ConsoleReader.GetPasswordAsByteArray();
            var encrypted = DataProtectionSample.Protect(toEncrypt);
            Console.WriteLine("this is your encrypted password.");
            DataProtectionSample.PrintValues(encrypted);
            Console.WriteLine("this is your encrypted password in human readable format. copy and keep safe!");
            var encrypedAsString = encrypted.ByteArrayToString("_");
            Console.WriteLine(encrypedAsString);
            Console.WriteLine("this is your decrypted password. please check this is what you meant to be encrypted!");
            var decrypted = DataProtectionSample.Unprotect(encrypted);
            DataProtectionSample.PrintValues(decrypted);
            Console.WriteLine("this is your decrypted password in human readable format. please check this is what you meant to be encrypted!");
            Console.WriteLine(decrypted.CharByteArrayToString());
            Console.WriteLine("press any key to exit");
            Console.ReadKey();
        }
    }
}
