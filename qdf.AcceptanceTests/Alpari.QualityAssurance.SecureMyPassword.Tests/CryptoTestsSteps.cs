using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;

namespace Alpari.QualityAssurance.SecureMyPassword.Tests
{
    [Binding]
    public class CryptoTestsSteps
    {
        [Given(@"my unencypted password is ""(.*)""")]
        public void GivenMyUnencyptedPasswordIs(string password)
        {
            var toEncrypt = password.ConvertStringToByteArray();
            ScenarioContext.Current["toEncrypt"] = toEncrypt;
        }

        [Given(@"my unencrypted password is ""(.*)""")]
        public void GivenMyUnencryptedPasswordIs(string password)
        {
            ScenarioContext.Current["toEncrypt"] = password;
        }

        [When(@"I directly encrypt my password")]
        public void WhenIDirectlyEncryptMyPassword()
        {
            var toEncrypt = ScenarioContext.Current["toEncrypt"].ToString();
            ScenarioContext.Current["encrypted"] = toEncrypt.Protect("-");
        }

        [When(@"I directly decrypt the encrypted password")]
        public void WhenIDirectlyDecryptTheEncryptedPassword()
        {
            var toUnEnCrypt = ScenarioContext.Current["encrypted"].ToString();
            ScenarioContext.Current["unEncrypted"] = toUnEnCrypt.UnProtect('-');
        }


        [When(@"encypt my password")]
        public void WhenEncyptMyPassword()
        {
            var toEncrypt =  ScenarioContext.Current["toEncrypt"] as byte[];
            ScenarioContext.Current["encrypted"] = toEncrypt.Protect();
            var encrypted = ScenarioContext.Current["encrypted"] as byte[];
            ScenarioContext.Current["encryptedAsString"] = encrypted.ByteArrayToString("-");
        }

        [When(@"I decrypt the encrypted password")]
        public void WhenIDecryptTheEncryptedPassword()
        {
            var toUnEnCrypt = ScenarioContext.Current["encryptedAsString"].ToString();
            var unEncryptArray = toUnEnCrypt.StringToByteArray('-');
            var unEncrypted = unEncryptArray.Unprotect();
            ScenarioContext.Current["unEncrypted"] = unEncrypted.CharByteArrayToString();
        }

        [Then(@"the decrypted password is ""(.*)""")]
        public void ThenTheDecryptedPasswordIs(string password)
        {
            var unencrypted = ScenarioContext.Current["unEncrypted"].ToString();
            unencrypted.Should().Be(password);
        }



    }
}
