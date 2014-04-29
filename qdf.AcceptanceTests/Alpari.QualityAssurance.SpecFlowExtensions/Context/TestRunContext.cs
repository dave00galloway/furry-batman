using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Context
{
    /// <summary>
    ///     SpecFlow does not provide a mechanism for sharing data, objects and context across features.
    ///     TestRunContext allows test designers to store data templates, SUT connections, manager classes etc. across an
    ///     entire test run
    ///     This object should not be used for storing data relating to specific tests, steps or even features - the
    ///     ScenarioContext should be used for most data that is created and accessed regularly throughout a test
    ///     The properties <seealso cref="StaticTime"></seealso>  and <seealso cref="StaticRandom"></seealso> can be used to
    ///     guarantee that 2 scenarios were run as prt of the same test run if so desired
    /// </summary>
    [Serializable]
// ReSharper disable once RedundantExtendsListEntry - conflicts with Visual Studio Code analysis
    public class TestRunContext : Dictionary<string, Object>, ISerializable
    {
        private const string Instantiated = "Instantiated";
        private static string _friendlyInstantiated;
        private const string RandomFileName = "RandomFileName";

        private static volatile TestRunContext _instance;
        private static readonly object SyncRoot = new Object();

        private TestRunContext()
        {
            DateTime now = DateTime.Now;
            Add(Instantiated, now + "  " + now.Ticks);
            Add(RandomFileName, GenerateRandomStringFromFileName());
        }

        /// <summary>
        ///     Implemented to staisfy
        ///     CA2237: Mark ISerializable types with SerializableAttribute
        ///     and CA2229: Implement serialization constructors
        ///     If this overload is ever used, then an instance will be created with serialisation context
        /// </summary>
        /// <param name="info"></param>
        /// <param name="context"></param>
        protected TestRunContext(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }

        public static TestRunContext Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (SyncRoot)
                    {
                        if (_instance == null)
                        {
                            _instance = new TestRunContext();
                        }
                    }
                }
                return _instance;
            }
        }

        /// <summary>
        ///     The time when the TestRunContext object was first instantiated.
        /// </summary>
        public static string StaticTime
        {
            get { return Instance[Instantiated].ToString(); }
        }

        /// <summary>
        ///     The time when the TestRunContext object was first instantiated in a filepath friendly format
        /// </summary>
        public static string StaticFriendlyTime
        {
            get
            {
                return _friendlyInstantiated ?? (_friendlyInstantiated = StaticTime.Replace(" ", "")
                    .Replace(@"\", "")
                    .Replace(@"/", "")
                    .Replace(@":", ""));
            }
        }


        /// <summary>
        ///     An 11 character random alphanumeric string generated when the TestRunContext object was first instantiated
        /// </summary>
        public static string StaticRandom
        {
            get { return Instance[RandomFileName].ToString(); }
        }

        /// <summary>
        ///     used internally to create <seealso cref="StaticRandom"></seealso> but is also a quick way to get a fairly random
        ///     alphanumeric string
        /// </summary>
        /// <returns></returns>
        public static string GenerateRandomStringFromFileName()
        {
            return Path.GetRandomFileName().Replace(".", "");
        }
    }
}