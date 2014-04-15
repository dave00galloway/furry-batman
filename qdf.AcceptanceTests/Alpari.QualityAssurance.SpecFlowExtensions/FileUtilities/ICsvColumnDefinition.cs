using System;
namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public interface ICsvColumnDefinition
    {
        System.Collections.Generic.Dictionary<string, int> ColumnDefinitionDictionary { get; }
        void SetupPropertiesAndDictionary(System.Collections.Generic.List<string> columns);
    }
}
