﻿using System;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Alpari.QualityAssurance.SpecFlowExtensions.Steps;

namespace qdf.AcceptanceTests.Steps
{
    public class StepCentral : MasterStepBase
    {
        public static DealReconciliationStepBase DealReconciliationStepBase
        {
            get
            {
                return (DealReconciliationStepBase) GetStepDefinition(DealReconciliationStepBase.FullName) ??
                       new DealReconciliationStepBase();
            }
        }

        public static DealReconciliationSteps DealReconciliationSteps
        {
            get
            {
                return (DealReconciliationSteps)GetStepDefinition(DealReconciliationSteps.FullName) ??
                       new DealReconciliationSteps();
            }
        }
    }
}