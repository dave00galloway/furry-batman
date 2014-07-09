@UKUSQDF-136
Feature: UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data
	In order to have confidence in the cnx-deals data
	As a QDF analyst
	I want to see that cnx-deals data matches dat from cnx admin hub

Scenario: reconcile yesterdays trades
	Given I have loaded yesterdays trades from csv
