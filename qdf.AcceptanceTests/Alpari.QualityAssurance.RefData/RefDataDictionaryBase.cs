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
    /// you can't use the NameValueCollection when the config is used in an external application
    /// </summary>
    public class RefDataDictionaryBase
    {
        public readonly ReadOnlyDictionary<string, string> Data;
        public string Name { get; private set; }

        public RefDataDictionaryBase(Dictionaries dictionaryName)
        {
            Name = Enum.GetName(typeof(Dictionaries), dictionaryName);
            IDictionary<string, string> dataDictionary = new Dictionary<string, string>();
            var config = ConfigurationManager.OpenExeConfiguration(String.Format("{0}.dll",GetType().Assembly.GetName().ToString()));//("Alpari.QualityAssurance.RefData.dll");
            var section = (AppSettingsSection)config.GetSection(Name);
            var data = section.Settings;

            foreach (string key in data.AllKeys)
            {
                dataDictionary[key] = data[key].Value;
            }   

            Data = new ReadOnlyDictionary<string, string>(dataDictionary);
        }
    }
}
