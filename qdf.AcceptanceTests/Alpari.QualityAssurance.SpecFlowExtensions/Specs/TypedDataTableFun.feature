﻿Feature: TypedDataTableFun
	In order to compare sets of actual and expected data
	As a Tester
	I want methods for comparing Typed Data Tables

Scenario: Compare Two matching data sets
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly

Scenario: Compare Two data sets one mismatch
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "mismatch"

Scenario: Compare Two data sets one missing
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "missing"

Scenario: Compare Two data sets one extra
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "extra"

@UKUSQDF_116
Scenario: Compare Two data sets one mismatch and export to csv
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "mismatch" :-
	| ExportType     | FileName | Path    | Overwrite |
	| DataTableToCsv | mismatch | C:\temp\ | true      |

@UKUSQDF_116
Scenario: Compare Two data sets one missing and export to csv
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "missing" :-
	| ExportType     | FileName | Path     | Overwrite |
	| DataTableToCsv | missing  | C:\temp\ | true      |

@UKUSQDF_116
Scenario: Compare Two data sets one extra and export to csv
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "extra" :-
	| ExportType     | FileName | Path     | Overwrite |
	| DataTableToCsv | extra    | C:\temp\ | true      |

@UKUSQDF_116
Scenario: Compare Two data sets one mismatch and export to console
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "mismatch" :-
	| ExportType         |
	| DataTableToConsole |

@UKUSQDF_116
Scenario: Compare Two data sets one missing and export to console
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "missing" :-
	| ExportType         |
	| DataTableToConsole |

@UKUSQDF_116
Scenario: Compare Two data sets one extra and export to console
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should contain 1 "extra" :-
	| ExportType         |
	| DataTableToConsole |

@UKUSQDF_116
Scenario: Compare Two data sets various diffs and export to csv
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname  | Age | Occupation  |
	| 1  | Vladimir  | Putin     | 97  | Impaler     |
	| 3  | Engleburt | Humpedick | 98  | Philosopher |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly:-
		| ExportType     |  Path     | Overwrite |
		| DataTableToCsv |  C:\temp\ | true      |

@UKUSQDF_146
Scenario: Compare Two matching data sets where ID is the same for 2 records
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	| 2  | John      | Putin    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	| 2  | John      | Putin    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly

@UKUSQDF_146
Scenario: Compare Two data sets of different types with one missing where ID is the same for 2 records
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	| 2  | John      | Putin    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data matching on id
	Then the person data should match exactly
#need a test which detects duplicates by checking on the common primary keys in each table
Scenario: Compare Two data sets of different types with one duplicate where ID is the same for 2 records
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	| 2  | John      | Putin    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data matching on id
	Then the person data should contain 1 "OriginalDuplicate" :-
	| ExportType         |
	| DataTableToConsole |