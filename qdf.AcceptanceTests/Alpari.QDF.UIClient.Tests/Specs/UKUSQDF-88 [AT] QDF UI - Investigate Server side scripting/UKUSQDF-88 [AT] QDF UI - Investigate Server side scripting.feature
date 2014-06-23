@UKUSQDF_88 @TeardownRedisConnection
Feature: UKUSQDF-88 [AT] QDF UI - Investigate Server side scripting
	In order to reduce query time
	As a QDF Analyst 
	I want to filter query results server side

Scenario: Connect to Redis Scripting Interface Hello World
	Given I have the following script "return 'Hello World!'" to send to redis cli
	When I send the script to redis cli
	Then the result should be "Hello World!"

Scenario: Connect to redis scripting interface and query deals
	Given I have a valid deal query script
	When I load the script to redis cli
	Then the result should be "Hello World!"
