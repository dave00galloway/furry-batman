using System;
using System.Diagnostics.CodeAnalysis;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    public class MasterStepBase
    {
        public static readonly string StepBaseRootNamspace = "Alpari.QualityAssurance.SpecFlowExtensions.StepBases.";

        [SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors",
            Justification =
                "Unable to mark this class as abstract, so using an exceptional method to prevent direct inheritance")]
        public MasterStepBase()
        {
            ScenarioContext.Current.Add(ToString(), this);
            ThrowExceptionIfInMasterStepBase();
            TestRunContext = TestRunContext.Instance;
        }


        /// <summary>
        ///     This property gets set when the first Step Def using a class inheriting from MasterStepBase.
        ///     Access by Context.TestRunContext to access the static members, instead of having to add
        ///     using Alpari.QualityAssurance.SpecFlowExtensions.Context;
        ///     to the top of every step def file
        /// </summary>
        public TestRunContext TestRunContext { get; private set; }

        /// <summary>
        ///     gets a named step definiton file from the Scenario context.
        ///     Can't make this a property without setting up an indexer for each step definition class file, which wouldn't be any
        ///     more friendly than the Cucumber-JVM Step Central pattern
        /// </summary>
        /// <param name="stepDefinition">the name of the step definition to retrieve</param>
        /// <returns></returns>
        public static MasterStepBase GetStepDefinition(string stepDefinition)
        {
            if (!ScenarioContext.Current.ContainsKey(stepDefinition))
            {
                return null;
            }
            return (MasterStepBase) ScenarioContext.Current[stepDefinition];
        }


        /// <summary>
        ///     This class can't be marked as abstract, but it shouldn't be directly inherited from
        /// </summary>
        private void ThrowExceptionIfInMasterStepBase()
        {
            if (ToString().Equals(StepBaseRootNamspace + "MasterStepBase"))
            {
                throw new NotSupportedException("Don't inherit directly from this class, define your own StepCentral inheriting from MasterStepBase!"
                                                +
                                                "This class can't be marked as abstract, but it shouldn't be directly inherited from");
            }
        }
    }
}