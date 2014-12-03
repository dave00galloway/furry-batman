using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using System;
using System.IO;
using System.Threading;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding, Scope(Tag = "UKUSQDF_170")]
    public class Ukusqdf170PreserveTestEvidenceBetweenExamplesSteps : StepCentral
    {
        public Ukusqdf170PreserveTestEvidenceBetweenExamplesSteps() : base(true)
        {
            
        }
        [Given(@"I create a file called ""(.*)""")]
        public void GivenICreateAFileCalled(string filename)
        {
            var wt = new WorkerThread(filename);
            Thread caller = new Thread(new ThreadStart(wt.CreateNewFile));
            caller.Start();
            //wt.CreateNewFile(filename);
            try
            {
                Thread.Sleep(500);
                caller.Abort();
            }
            catch
            {
            }
            caller.Join();
            //caller.
        }



        [Given(@"I waste some time")]
        public void GivenIWasteSomeTime()
        {
            for (int i = 0; i < 10; i++)
            {
                Thread.Sleep(1000);
            }
        }
    }

    public class WorkerThread
    {
        public string Filename { get; set; }

        public WorkerThread(string filename)
        {
            Filename = filename;
            //throw new NotImplementedException();
        }

        public void CreateNewFile()
        {
            File.Create(String.Format("{0}{1}.csv", MasterStepBase.ScenarioOutputDirectory, Filename));
        }
    }
}
