using System;
using System.Diagnostics.CodeAnalysis;
using Alpari.QualityAssurance.SpecFlowExtensions.Steps;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    /// <summary>
    ///     Use this as a pattern for enabling cross step definition calls.
    ///     Do Not inherit directly from this class!
    ///     TODO:- http://msdn.microsoft.com/en-us/library/yctbsyf4.aspx Create a custom inheritance permission?
    /// </summary>
    public class StepCentral : MasterStepBase
    {
        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors",
            Justification =
                "Unable to mark this class as abstract, so using an exceptional method to prevent direct inheritance")]
        public StepCentral()
        {
            ThrowExceptionIfNotInSpecFlowExtensionsNamespace();
        }

        /// <summary>
        ///     Use this to specify whether to ignore the namespace rule - this is needed for testing access of TestRunContext
        ///     without having to fully qualify it's namespace in every StepDef file
        /// </summary>
        /// <param name="ignoreNameSpace"></param>
        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors",
            Justification =
                "Unable to mark this class as abstract, so using an exceptional method to prevent direct inheritance")]
        public StepCentral(bool ignoreNameSpace)
        {
            if (!ignoreNameSpace)
            {
                ThrowExceptionIfNotInSpecFlowExtensionsNamespace();
            }
        }

        public static CrossStepDefinitionFileOne CrossStepDefinitionFileOne
        {
            get
            {
                return
                    (CrossStepDefinitionFileOne)
                        GetStepDefinition(CrossStepDefinitionFileOne.FullName) ?? new CrossStepDefinitionFileOne();
            }
        }

        public static TypedDataTableFunSteps TypedDataTableFunSteps
        {
            get
            {
                return (TypedDataTableFunSteps) GetStepDefinition(TypedDataTableFunSteps.FullName) ??
                       new TypedDataTableFunSteps();
            }
        }

        public static CsvConversionSteps CsvConversionSteps
        {
            get
            {
                return (CsvConversionSteps) GetStepDefinition(CsvConversionSteps.FullName) ?? new CsvConversionSteps();
            }
        }

        private void ThrowExceptionIfNotInSpecFlowExtensionsNamespace()
        {
            if (!ToString().StartsWith(StepBaseRootNameSpace))
            {
                throw new NotSupportedException(
                    "Don't inherit directly from this class, define your own StepCentral inheriting from MasterStepBase!");
            }
        }
    }
}