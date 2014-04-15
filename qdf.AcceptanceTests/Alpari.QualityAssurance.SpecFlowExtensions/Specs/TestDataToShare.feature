Feature: TestDataToShare
	In order to avoid repeating set up data in feature files
	As a tester
	I want to be able to save test data for a whole test run

@mytag
Scenario: Setup test data
	Given I have setup the following templated test data as "defaultUser":
		| howMuch | title | firstName | middleName | dob_day | dob_month | dob_year |
		| £350    | Mr    | John      | Smith      | 12      | 11        | 1979     |

Scenario: Save test data
	Given I have the following templated test data:
		| baseDetails | newDetails  | howMuch | title | firstName | middleName | 
		| defaultUser | myNewUser   | £350    | Miss  | Keira     | Knightly   | 
		| defaultUser | myNewerUser | £400    | Ms    | Natalie   | Portman    | 