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
    public class TestRunContext : Dictionary<string, Object>, ISerializable
    {
        private static readonly string Instantiated = "Instantiated";
        private static readonly string RandomFileName = "RandomFileName";

        private static volatile TestRunContext instance;
        private static readonly object syncRoot = new Object();

        private TestRunContext()
        {
            var now = DateTime.Now;
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
            var serialisationInstance = Instance;
        }

        public static TestRunContext Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (syncRoot)
                    {
                        if (instance == null)
                        {
                            instance = new TestRunContext();
                        }
                    }
                }
                return instance;
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