using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QA.CC.MT4Positions2RedisTests.Transforms;
using AlpariUK.Mt4.Wrapper;
using AlpariUK.Mt4.Wrapper.Enums;
using AlpariUK.Mt4.Wrapper.Types;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4DotNetManagerWrapperSteps : StepCentral
    {
        public new static readonly string FullName = typeof (Mt4DotNetManagerWrapperSteps).FullName;
        public Manager Manager { get; private set; }

        [Given(@"I have connected to the MT4 Manger API:-")]
        public void GivenIHaveConnectedToTheMtMangerApi(Mt4ApiConnectionParameters connectionParameters)
        {
            Manager = new Manager(connectionParameters.Server, connectionParameters.Login,
                connectionParameters.Password);
            Manager.Connect();
        }

        [When(@"I query open positions for user ""(.*)""")]
        public void WhenIQueryOpenPositionsForUser(int login)
        {
            List<TradeRecord> positions =
                Manager.TradesRequest()
                    .Where(t => t.Login == login
                                && (t.Cmd != TradeCommand.OP_BALANCE || t.Cmd != TradeCommand.OP_CREDIT))
                    .ToList();
        }

        [When(@"I add an account using manager API")]
        public void WhenIAddAnAccountUsingManagerApi()
        {
            //var userToCopy = Manager.UserRecordGet()

            //var userRecord = new UserRecord
            //{
            //    Address = 
            //}
            //Manager.UserRecordNew(ref userRecord);
            ScenarioContext.Current.Pending();
        }

        [When(@"I copy account (.*) using manager API")]
        public void WhenICopyAccountUsingManagerApi(int login)
        {
            Manager.Connect();
           // var userToCopy = Manager.UserRecordGet(login);

            //var userRecord = new UserRecord
            //{
            //    Address = userToCopy.Address,
            //    AgentAccount = userToCopy.AgentAccount,
            //    ApiData = userToCopy.ApiData,
            //    Balance = userToCopy.Balance,
            //    BalanceStatus = userToCopy.BalanceStatus,
            //    City = userToCopy.City,
            //    Comment = userToCopy.Comment,
            //    Country = userToCopy.Country,
            //    Credit = userToCopy.Credit,
            //    Email = userToCopy.Email,
            //    Enable = userToCopy.Enable,
            //    Group = userToCopy.Group,
            //    EnableReserved = userToCopy.EnableReserved,
            //    EnableReadOnly = userToCopy.EnableReadOnly,
            //    EnableChangePassword = userToCopy.EnableChangePassword,
            //    //Id = userToCopy.Id
            //    Interestrate = userToCopy.Interestrate,
            //    //Lastdate = 
            //    Leverage = userToCopy.Leverage,
            //    //Login = 
            //    Name = userToCopy.Name,
            //    Password = userToCopy.Password, //"1q2w3e",
            //    PasswordInvestor = userToCopy.PasswordInvestor, //= "1q2w3e",
            //    PasswordPhone = userToCopy.PasswordPhone,
            //    PrevBalance = userToCopy.PrevBalance,
            //    Phone = userToCopy.Phone,
            //    PrevEquity = userToCopy.PrevEquity,
            //    PrevMonthBalance = userToCopy.PrevMonthBalance,
            //    PrevMonthEquity = userToCopy.PrevMonthEquity,
            //    //PublicKey = 
            //    //Regdate = userToCopy.Regdate
            //    SendReports = userToCopy.SendReports,
            //    State = userToCopy.State,
            //    Status = userToCopy.Status,
            //    Taxes = userToCopy.Taxes,
            //    //Timestamp = 
            //    UserColor = userToCopy.UserColor,
            //    Zipcode = userToCopy.Zipcode
            //};

            for (int i = 0; i < 64;i++)
            {

                //var userToCopy = Manager.UserRecordGet(login);

                //var userRecord = new UserRecord
                //{
                //    Address = userToCopy.Address,
                //    AgentAccount = userToCopy.AgentAccount,
                //    ApiData = userToCopy.ApiData,
                //    Balance = userToCopy.Balance,
                //    BalanceStatus = userToCopy.BalanceStatus,
                //    City = userToCopy.City,
                //    Comment = userToCopy.Comment,
                //    Country = userToCopy.Country,
                //    Credit = userToCopy.Credit,
                //    Email = userToCopy.Email,
                //    Enable = userToCopy.Enable,
                //    Group = userToCopy.Group,
                //    EnableReserved = userToCopy.EnableReserved,
                //    EnableReadOnly = userToCopy.EnableReadOnly,
                //    EnableChangePassword = userToCopy.EnableChangePassword,
                //    //Id = userToCopy.Id
                //    Interestrate = userToCopy.Interestrate,
                //    //Lastdate = 
                //    Leverage = userToCopy.Leverage,
                //    //Login = 
                //    Name = userToCopy.Name,
                //    Password = userToCopy.Password, //"1q2w3e",
                //    PasswordInvestor = userToCopy.PasswordInvestor, //= "1q2w3e",
                //    PasswordPhone = userToCopy.PasswordPhone,
                //    PrevBalance = userToCopy.PrevBalance,
                //    Phone = userToCopy.Phone,
                //    PrevEquity = userToCopy.PrevEquity,
                //    PrevMonthBalance = userToCopy.PrevMonthBalance,
                //    PrevMonthEquity = userToCopy.PrevMonthEquity,
                //    //PublicKey = 
                //    //Regdate = userToCopy.Regdate
                //    SendReports = userToCopy.SendReports,
                //    State = userToCopy.State,
                //    Status = userToCopy.Status,
                //    Taxes = userToCopy.Taxes,
                //    //Timestamp = 
                //    UserColor = userToCopy.UserColor,
                //    Zipcode = userToCopy.Zipcode
                //};

                var userRecord = new UserRecord
                {
                    Address = "201 Bishopsgate, London EC2M 3AB, UK",
                    //AgentAccount = userToCopy.AgentAccount,
                    //ApiData = userToCopy.ApiData,
                    //Balance = userToCopy.Balance,
                    //BalanceStatus = userToCopy.BalanceStatus,
                    City = "London",
                    Comment = "Test",
                    Country = "United Kingdom",
                    //Credit = userToCopy.Credit,
                    Email = "dgalloway@dgalloway.co.uk",
                    Enable = 1,
                    Group = "BookA_GBP",
                    //EnableReserved = userToCopy.EnableReserved,
                    EnableReadOnly = 0,
                    EnableChangePassword = 1,
                    //Id = userToCopy.Id
                    //Interestrate = userToCopy.Interestrate,
                    //Lastdate = 
                    Leverage = 100,
                    //Login = 
                    Name = "David Galloway",
                    Password = "1q2w3e",
                    PasswordInvestor = "1q2w3e",
                    //PasswordPhone = "",
                    //PrevBalance = userToCopy.PrevBalance,
                    Phone = "02074562800",
                    //PrevEquity = userToCopy.PrevEquity,
                    //PrevMonthBalance = userToCopy.PrevMonthBalance,
                    //PrevMonthEquity = userToCopy.PrevMonthEquity,
                    //PublicKey = 
                    //Regdate = userToCopy.Regdate
                    SendReports = 1,
                    //State = userToCopy.State,
                    //Status = userToCopy.Status,
                    //Taxes = userToCopy.Taxes,
                    //Timestamp = 
                    UserColor = -1,
                    Zipcode = "EC2M 3AB"
                };

                var res = Manager.UserRecordNew(ref userRecord);
                Console.WriteLine(res);
                var tradeInfo = new TradeTransInfo
                {
                    Type = TradeTransactionType.TT_BR_BALANCE,
                    Cmd = Convert.ToByte(TradeCommand.OP_BALANCE),
                    Price = Convert.ToDouble(99999999999999.99),
                    OrderBy = Convert.ToInt32(res),
                    Comment = "Test initial Deposit"
                };

                Console.WriteLine(Manager.TradeTransaction(ref tradeInfo));
            }


        }


    }
}