Feature: SetupUIControls
	In order to select search options
	As a QDF Analyst
	I want search options to be accurate and complete

@mytag
Scenario: Set up trade server list
	Given I filter deals by server
	Then the list of server options should be:
	| Server               |
	| Unknown              |
	| Mt4CapitalBankJordan |
	| Mt4Pro               |
	| Currenex             |
	| Mt4Micro1            |
	| Mt4Micro2            |
	| Mt4Classic1          |
	| Mt4Classic2          |
	| Mt4JapaneseC1        |
	| Mt5Pro               |
	| Mt4MarketMena        |
	| Mt4SpreadBetting     |
	| Mt4Market1           |
	| Mt4B2B               |
	| Coverage101          |
	| Coverage601          |
	| Coverage602          |
	| Coverage604          |

Scenario: Set up book list
	Given I filter deals by book
	Then the list of book options should be:
	| Book |
	| None |
	| A    |
	| B    |

