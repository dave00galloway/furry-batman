namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public class Mt4ApiConnectionParameters
    {
        private const int CONNECTION_TIMEOUT = 10000;
        private int _connectionTimeout = CONNECTION_TIMEOUT;
        public string Server { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }

        public int ConnectionTimeout
        {
            get { return _connectionTimeout; }
            set { _connectionTimeout = value; }
        }
    }
}