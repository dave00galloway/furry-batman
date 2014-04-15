﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public abstract class CsvColumnDefinition : ICsvColumnDefinition
    {
        /// <summary>
        /// Primarily for testing purposes - use the actual properties when querying files
        /// </summary>
        public Dictionary<string,int> ColumnDefinitionDictionary {get; private set;}

        public CsvColumnDefinition(List<string> columns)
        {
            SetupPropertiesAndDictionary(columns);
        }

        /// <summary>
        /// Setup (or replace) the column Definition for this class
        /// Should only be called from the constructor, but provided as a public method so it can be enforced as an interface
        /// </summary>
        /// <param name="columns"></param>
        public void SetupPropertiesAndDictionary(List<string> columns)
        {
            //TODO: - linqify!
            ColumnDefinitionDictionary = new Dictionary<string, int>();
            int colIndex = 0;
            foreach (var col in columns)
            {
                PropertyInfo columnDefinition = this.GetType().GetProperty(col.Replace(" ", ""));
                columnDefinition.SetValue(this, colIndex);
                ColumnDefinitionDictionary[col] = colIndex;
                colIndex++;
            }
        }
    }
}
