using System;

namespace Alpari.QualityAssurance.SecureMyPassword
{
    /// <summary>
    ///     uses a combination of techniques found from
    ///     http://msdn.microsoft.com/en-us/library/system.security.securestring.aspx
    ///     and
    ///     http://msdn.microsoft.com/en-us/library/system.security.cryptography.protecteddata.aspx
    ///     to create a password
    /// </summary>
    public class Program
    {
        public static void Main(string[] args)
        {
            byte[] toEncrypt = ConsoleReader.GetPasswordAsByteArray();
            byte[] encrypted = toEncrypt.Protect();
            Console.WriteLine("this is your encrypted password.");
            encrypted.PrintValues();
            Console.WriteLine("this is your encrypted password in human readable format. copy and keep safe!");
            string encrypedAsString = encrypted.ByteArrayToString("_");
            Console.WriteLine(encrypedAsString);
            Console.WriteLine("this is your decrypted password. please check this is what you meant to be encrypted!");
            byte[] decrypted = encrypted.Unprotect();
            decrypted.PrintValues();
            Console.WriteLine(
                "this is your decrypted password in human readable format. please check this is what you meant to be encrypted!");
            Console.WriteLine(decrypted.CharByteArrayToString());
            Console.WriteLine("press any key to exit");
            Console.ReadKey();
        }
    }
}