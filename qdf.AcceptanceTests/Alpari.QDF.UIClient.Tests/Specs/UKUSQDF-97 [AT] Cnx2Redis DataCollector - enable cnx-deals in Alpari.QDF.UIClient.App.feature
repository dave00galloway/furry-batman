@UKUSQDF_97
Feature: UKUSQDF-97 [AT] [AT] Cnx2Redis DataCollector - enable cnx-deals in Alpari.QDF.UIClient.App
	In order to test cnx-deals are imported to Redis
	As a QDF tester
	i want to be able to query for cnx-deals in Alpari.QDF.UIClient.App

Scenario: Filter deals by date
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 19/06/2014  17:35:00 | 19/06/2014  17:45:00 |
	When I retrieve the qdf deal data
	Then no retrieved deal will have a timestamp outside "19/06/2014  17:35:00" to "19/06/2014  17:45:00"
	And the count of retrieved deals will be 11 
