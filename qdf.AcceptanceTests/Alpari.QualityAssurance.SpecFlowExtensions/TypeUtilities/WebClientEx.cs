using System;
using System.Net;
using System.Security.Cryptography.X509Certificates;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// An extended WebClient that keeps track of cookies (e.g. session id) and can load a certificate if required
    ///     http://stackoverflow.com/questions/2066489/how-can-you-add-a-certificate-to-webclient-c
    ///     http://stackoverflow.com/questions/6502581/how-to-maintaine-cookies-in-between-two-urls-in-asp-net
    ///     http://stackoverflow.com/questions/17840825/cryptographicexception-was-unhandled-system-cannot-find-the-specified-file
    /// </summary>
    public class WebClientEx : WebClient
    {
        public readonly string CertificateFilenamePath;
        public readonly string Password;

        public WebClientEx()
        {
            
        }

        public WebClientEx(string certificateFilenamePath, string password)
        {
            CookieContainer = new CookieContainer();
            CertificateFilenamePath = certificateFilenamePath;
            Password = password;
        }

        public CookieContainer CookieContainer { get; private set; }

        protected override WebRequest GetWebRequest(Uri address)
        {
            var request = (HttpWebRequest) base.GetWebRequest(address);
            if (request != null)
            {
                request.Timeout = 200000;
                if (CertificateFilenamePath != null && Password != null)
                    request.ClientCertificates.Add(new X509Certificate2(CertificateFilenamePath, Password,
                        X509KeyStorageFlags.MachineKeySet));
                request.CookieContainer = CookieContainer;
            }
            return request;
        }
    }
}