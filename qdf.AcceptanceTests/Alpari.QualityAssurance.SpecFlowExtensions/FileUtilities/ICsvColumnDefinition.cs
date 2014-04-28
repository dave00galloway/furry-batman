using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public interface ICsvColumnDefinition
    {
        Dictionary<string, int> ColumnDefinitionDictionary { get; }
        void SetupPropertiesAndDictionary(List<string> columns);
    }
}