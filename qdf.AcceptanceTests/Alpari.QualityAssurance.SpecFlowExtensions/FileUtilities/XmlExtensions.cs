using System;
using System.Collections.Concurrent;
using System.Linq;
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
        ///     code from David Lindsay, adapted to work as an extension method
        /// </summary>
        /// <param name="pathToYourXmlFile">the path to the xml</param>
        /// <param name="id">the id of the element look under, usually the root element</param>
        /// <returns></returns>
        public static ConcurrentDictionary<String, Object> ParseXmlAsDictionary(this string pathToYourXmlFile, String id)
        {
            XDocument database = XDocument.Load(pathToYourXmlFile);

            var map = new ConcurrentDictionary<string, Object>();

            foreach (XElement subElement in database.Elements(id).SelectMany(element => element.Elements()))
            {
                map[subElement.Name.ToString()] = subElement.Value;
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
            XDocument database = XDocument.Load(pathToYourXmlFile);

            var map = new ConcurrentDictionary<string, Object>();

            if (database.Root == null) return map;
            foreach (XElement subElement in database.Root.Elements().SelectMany(element => element.Elements()))
            {
                map[subElement.Name.ToString()] = subElement.Value;
            }
            return map;
        }
    }
}