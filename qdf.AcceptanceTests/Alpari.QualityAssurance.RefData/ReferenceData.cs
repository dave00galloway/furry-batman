using System;
using System.Collections.ObjectModel;

namespace Alpari.QualityAssurance.RefData
{
    /// <summary>
    /// Lazy threadsafe singleton which lazy loads ReadOnly dictionaries from config
    /// To Use this in a client app:-
    /// add this property group to the project's .csproj and rebuild
    ///     <PropertyGroup>
    ///     <AllowedReferenceRelatedFileExtensions>
    ///     .pdb;
    ///     .xml;
    ///     .dll.config
    ///     </AllowedReferenceRelatedFileExtensions>
    ///     </PropertyGroup>
    /// TODO:- investigate using Lazy<typeparam name=">">to set up the dictionaries</typeparam>
    /// </summary>
    public class ReferenceData
    {
        private static volatile ReferenceData _instance;
// ReSharper disable once UnassignedReadonlyField.Compiler
        private static readonly object SyncRoot = new Object();
        private ReadOnlyDictionary<string, string> _qdfToCcServerMapping;
        private ReadOnlyDictionary<string, string> _ccToQdfServerMapping;

        private ReferenceData()
        {
            
        }

        public static ReferenceData Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (SyncRoot)
                    {
                        if (_instance == null)
                        {
                            _instance = new ReferenceData();
                        }
                    }
                }
                return _instance;
            }
        }

        public ReadOnlyDictionary<string, string> QdfToCcServerMapping
        {
            get
            {
                if (_qdfToCcServerMapping == null)
                {
                    lock (SyncRoot)
                    {
                        if (_qdfToCcServerMapping == null)
                        {
                            _qdfToCcServerMapping = new RefDataDictionaryBase(Dictionaries.QdfToCcServerMapping).Data;
                        }
                    }                    
                }
                return _qdfToCcServerMapping;
            }
        }

        public ReadOnlyDictionary<string, string> CcToQdfServerMapping
        {
            get
            {
                if (_ccToQdfServerMapping == null)
                {
                    lock (SyncRoot)
                    {
                        if (_ccToQdfServerMapping == null)
                        {
                            _ccToQdfServerMapping = new RefDataDictionaryBase(Dictionaries.CcToQdfServerMapping).Data;
                        }
                    }                    
                }
                return _ccToQdfServerMapping;
            }
        }
    }
}
