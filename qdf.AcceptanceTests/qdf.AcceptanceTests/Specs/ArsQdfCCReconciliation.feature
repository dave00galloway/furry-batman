Feature: Deal Reconciliation
In Order to have faith in the QDF data 
As a quant user
I want a reconciliation of ARS QDF against CC

Scenario: Book A Deals for server C1 in symbol EURUSD in QDF should equal CC from 5 minutes ago
	Given I have QDF Deal Data
	| server | symbol | startTime | endTime |
	| C1     | EURUSD | -7D       | +5MIN   |
	#Given I have QDF Deal Data
	#| server | symbol | 
	#| C1     | EURUSD |  
		And I have CC data
	When I compare QDF and CC data
	Then the data should match