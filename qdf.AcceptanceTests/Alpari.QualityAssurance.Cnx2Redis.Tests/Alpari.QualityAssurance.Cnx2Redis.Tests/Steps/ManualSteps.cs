﻿using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding, Scope(Tag = "manual")]
    public class ManualSteps
    {
        [Given(".*"), When(".*"), Then(".*")]
        public void EmptyStep()
        {
        }

        [Given(".*"), When(".*"), Then(".*")]
        public void EmptyStep(string multiLineStringParam)
        {
        }

        [Given(".*"), When(".*"), Then(".*")]
        public void EmptyStep(Table tableParam)
        {
        }
    }
}
