using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class Mt4DotNetWrapperTransforms
    {
        [StepArgumentTransformation]
        public static Mt4ClientConnectionParameters Mt4ClientConnectionParametersTransform(Table table)
        {
            return table.CreateInstance<Mt4ClientConnectionParameters>();
        }
    }

    public class Mt4ClientConnectionParameters
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
