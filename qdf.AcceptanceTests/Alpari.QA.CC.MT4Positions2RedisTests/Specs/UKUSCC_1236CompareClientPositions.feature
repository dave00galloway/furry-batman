@UKUSCC_1236 @CCDataContextPool @Mt4ArsPositionsContext
Feature: UKUSCC_1236CompareClientPositions
	In order to find discrepancies in redis and ars open positions
	As a CC tester
	I want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3

Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcSlave     |

Scenario: Create 2 connections 2 CC on different connection strings
	Then the count of cc connections is 2

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| C1      | MT4AUKC01 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| C2      | MT4AUKC02 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2    | Database1 | Database2 | Connection1 | Connection2                |
	| B2B     | MT4AUKB2B1 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare JPN Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2  | Database1 | Database2 | Connection1 | Connection2                |
	| JPN     | MT4JPC01 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2    | Database1 | Database2 | Connection1 | Connection2                |
	| CBoJ     | MT4AUKCBJ | cc        | 12        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| M1      | MT4AUKM01 | cc        | 12        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| M2      | MT4AUKM02 | cc        | 12        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKP01 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| Pro     | MT4AUKP01 | cc        | 12        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2       | Database1 | Database2 | Connection1 | Connection2                |
	| MK1     | MT4AUKMARKET1 | cc        | 13        | CcMaster    | uk-redis-cc1.dc.alpari.com |  
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2          | Database1 | Database2 | Connection1 | Connection2                |
	| MENA    | MT4AUKMARKETMENA | cc        | 13        | CcMaster    | uk-redis-cc1.dc.alpari.com |  
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| SB1     | MT4AUKSB1 | cc        | 13        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |