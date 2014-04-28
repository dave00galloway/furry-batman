using System;
using System.Collections.Concurrent;
using System.Xml.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    ///     Extension methods for working with xml files & streams
    /// </summary>
    public static class XmlExtensions
    {
        /// <summary>
        ///     Extension method for turning a flat xml file into a concurrent dictionary.
        ///     code from David Lindsay, adapted to work as an extenion method
        /// </summary>
        /// <param name="pathToYourXmlFile">the path to the xml</param>
        /// <param name="id">the id of the element look under, usually the root element</param>
        /// <returns></returns>
        public static ConcurrentDictionary<String, Object> ParseXmlAsDictionary(this string pathToYourXmlFile, String id)
        {
            var database = XDocument.Load(pathToYourXmlFile);

            var map = new ConcurrentDictionary<string, Object>();

            foreach (var element in database.Elements(id))
            {
                foreach (var subElement in element.Elements())
                {
                    map[subElement.Name.ToString()] = subElement.Value;
                }
            }
            return map;
        }

        /// <summary>
        ///     overload of ConcurrentDictionary String, Object ParseXmlAsDictionary(this string pathToYourXmlFile, String id)
        ///     which doesn't require an id.
        ///     the root is always used
        /// </summary>
        /// <param name="pathToYourXmlFile">the path to the xml</param>
        /// <returns></returns>
        public static ConcurrentDictionary<String, Object> ParseXmlAsDictionary(this string pathToYourXmlFile)
        {
            var database = XDocument.Load(pathToYourXmlFile);

            var map = new ConcurrentDictionary<string, Object>();

            foreach (var element in database.Root.Elements())
            {
                foreach (var subElement in element.Elements())
                {
                    map[subElement.Name.ToString()] = subElement.Value;
                }
            }
            return map;
        }
    }
}