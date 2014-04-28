using System;
using System.Diagnostics.CodeAnalysis;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public abstract class CrossStepDefinitionFileOneStepBase : CrossStepDefinitionStepBase
    {
        private string _lazyProperty;

        protected CrossStepDefinitionFileOneStepBase()
        {
            _lazyProperty = null;
        }

        [SuppressMessage("Microsoft.Design", "CA1065:DoNotRaiseExceptionsInUnexpectedLocations",
            Justification =
                "This is an exceptional exception used to illustrate a point in a test about lazy properties and data persistence, which will not normally be used"
            )]
        public string LazyProperty
        {
            get
            {
                if (_lazyProperty == null)
                {
                    throw new NullReferenceException(
                        " this property must be set by a member of the class it is defined in");
                }
                Console.WriteLine("get _lazyProperty = " + _lazyProperty);
                return _lazyProperty;
            }

            protected set
            {
                if (_lazyProperty == null)
                {
                    _lazyProperty = value;
                    ScenarioContext.Current.Add("lazyProperty", _lazyProperty);
                }
                Console.WriteLine("set _lazyProperty = " + _lazyProperty);
            }
        }

        public static CrossStepDefinitionFileOne Get()
        {
            return
                (CrossStepDefinitionFileOne)
                    GetStepDefinition(MasterStepBase.StepBaseRootNamspace + "CrossStepDefinitionFileOne");
        }
    }
}