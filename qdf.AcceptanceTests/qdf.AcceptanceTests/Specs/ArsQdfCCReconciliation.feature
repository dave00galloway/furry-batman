Feature: Deal Reconciliation
In Order to have faith in the QDF data 
As a quant user
I want a reconciliation of ARS QDF against CC

Scenario: Book A Deals for server C1 in symbol EURUSD in QDF should equal CC from 5 minutes ago
Given I have QDF Data 
And I have CC data
When I compare QDF and CC data
Then the data should match