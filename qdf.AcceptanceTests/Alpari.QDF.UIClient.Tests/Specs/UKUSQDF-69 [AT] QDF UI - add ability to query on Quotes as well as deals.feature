﻿@UKUSQDF_69
Feature:UKUSQDF-69 [AT] QDF UI - add ability to query on Quotes as well as deals
	In order to get information about quotes
	As a QDF Analyst
	I want access to quote data in QDF

Scenario: Filter quotes by date
	Given I have the following search criteria for qdf quotes
	 | ConvertedStartTime   | ConvertedEndTime     |
	 | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	Then no retrieved quote will have a timestamp outside "09/06/2014  09:00:00" to "09/06/2014  09:05:00"
	And the count of retrieved deals quotes be 10760
