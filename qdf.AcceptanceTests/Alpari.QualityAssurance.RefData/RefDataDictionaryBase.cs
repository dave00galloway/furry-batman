using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Configuration;
using System.Reflection;
using System.Xml;

namespace Alpari.QualityAssurance.RefData
{
    /// <summary>
    /// Creates a dictionary from the named section in App.Config passed as a constructor argument
    /// Currently the dictionary is read only, so adding new entries will require a restart
    /// http://stackoverflow.com/questions/3461418/how-to-get-the-values-of-a-configurationsection-of-type-namevaluesectionhandler
    /// http://stackoverflow.com/questions/9765686/include-referenced-projects-config-file
    /// http://stackoverflow.com/questions/594298/c-sharp-dll-config-file
    /// note suggestions to set the type as System.Configuration.AppSettingsSection
    /// </summary>
    public class RefDataDictionaryBase
    {
        public readonly ReadOnlyDictionary<string, string> Data;
        public string Name { get; private set; }

        public RefDataDictionaryBase(Dictionaries dictionaryName)
        {
            Name = Enum.GetName(typeof(Dictionaries), dictionaryName);
            IDictionary<string, string> dataDictionary = new Dictionary<string, string>();
            var data = ConfigurationManager.GetSection(Name) as NameValueCollection;
            if (data == null)
            {
                var config = ConfigurationManager.OpenExeConfiguration("Alpari.QualityAssurance.RefData.dll");
                var section = config.GetSection(Name) ;
                var rawXml = section.SectionInformation.GetRawXml();
                var xmlDocument = new XmlDocument();
                xmlDocument.Load(rawXml);
                var sectionHandlerType = Type.GetType(section.SectionInformation.Type);
                IConfigurationSectionHandler sectionHandler = (IConfigurationSectionHandler)Activator.CreateInstance(sectionHandlerType);
                data = (NameValueCollection)sectionHandler.Create(null, null, xmlDocument.DocumentElement);
            }
            foreach (string key in data.AllKeys)
            {
                dataDictionary[key] = data.Get(key);
            }   

            Data = new ReadOnlyDictionary<string, string>(dataDictionary);
        }
    }
}
