using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using TechTalk.SpecFlow;
using FluentAssertions;
using FluentAssertions.Collections;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    public class MasterStepBase
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors",
            Justification = "Unable to mark this class as abstract, so using an exceptional method to prevent direct inheritance")]
        public MasterStepBase()
        {
            ScenarioContext.Current.Add(this.ToString(), this);
            ThrowExceptionIfInMasterStepBase();
            testRunContext = TestRunContext.Instance;

        }

        public static readonly string STEP_BASE_ROOT_NAMSPACE = "Alpari.QualityAssurance.SpecFlowExtensions.StepBases.";


        private TestRunContext testRunContext;
        /// <summary>
        /// This property gets set when the first Step Def using a class inheriting from MasterStepBase.
        /// Access by Context.TestRunContext to access the static members, instead of having to add 
        /// using Alpari.QualityAssurance.SpecFlowExtensions.Context; 
        /// to the top of every step def file
        /// </summary>
        public TestRunContext TestRunContext 
        {
            get
            {
                return testRunContext;
            }
            private set
            {
                testRunContext = value;
            }
        }

        /// <summary>
        /// gets a named step definiton file from the Scenario context.
        /// Can't make this a property without setting up an indexer for each step definition class file, which wouldn't be any more friendly than the Cucumber-JVM Step Central pattern
        /// </summary>
        /// <param name="stepDefinition">the name of the step definition to retrieve</param>
        /// <returns></returns>
        public static MasterStepBase GetStepDefinition(string stepDefinition)
        {
            if (!ScenarioContext.Current.ContainsKey(stepDefinition))
            {
                return null;
            }
            return (MasterStepBase)ScenarioContext.Current[stepDefinition];
        }



        /// <summary>
        /// This class can't be marked as abstract, but it shouldn't be directly inherited from
        /// </summary>
        private void ThrowExceptionIfInMasterStepBase()
        {
            if (this.ToString().Equals(STEP_BASE_ROOT_NAMSPACE + "MasterStepBase"))
            {
                throw new NotSupportedException("Don't inherit directly from this class, define your own StepCentral inheriting from MasterStepBase!"
                    + "This class can't be marked as abstract, but it shouldn't be directly inherited from");
            }
        }
    }
}
