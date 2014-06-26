@UKUSQDF_91 @manual
Feature: UKUSQDF-91 [AT] Cnx2Redis Data Collector - Network Failure Tests
	In order to have confidence in the reliability of the Cnx2Redis infrastructure
	As a Qdf Analyst
	I want the Cnx2Redis to cope with loss of connectivity

Background:- connectivity will be broken for 10 minutes in each scenario

Scenario: Loss of Redis connection
	Given Cnx2Redis trades are flowing to Redis
	When the IP of the data collector is added to the blocked list on the Redis server
		And the IP of the data collector is removed from the blocked list on the Redis server
	Then trades start flowing to redis
		And Cnx2Redis logs show the pause and resumption of trade flow
		And AUKTEST_hedge shows trades flowing for the duration of the test including the loss of connection

Scenario: Loss of FIX connection
	Given Cnx2Redis trades are flowing to Redis
	When the IP of the FIX engine is added to the blocked list on the data collector server
		And the IP of the FIX engine is removed from the blocked list on the data collector server
	Then trades start flowing to redis
		And Cnx2Redis logs show the pause and resumption of trade flow
		But AUKTEST_hedge does not show trades flowing for the duration of  the loss of connection

Scenario: Loss of CnxStp_Test service
	Given Cnx2Redis trades are flowing to Redis
	When the CnxStp_Test service is stopped
		And the CnxStp_Test service is restarted
	Then trades start flowing to redis
		And Cnx2Redis logs show the pause and resumption of trade flow
		But AUKTEST_hedge does not show trades flowing for the duration of  the loss of connection

Scenario: Loss of DataCollector service
	Given Cnx2Redis trades are flowing to Redis
	When the DataCollector service is stopped
		And the DataCollector service is restarted
	Then trades start flowing to redis
		And Cnx2Redis logs show the pause and resumption of trade flow
		But AUKTEST_hedge does not show trades flowing for the duration of  the loss of connection