@UKUSCC_1236 
Feature: UKUSCC_1236CompareClientPositionsXlsx
	In order to find discrepancies in redis and ars open positions
	As a CC tester
	I want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                  |
	| H:\Downloads\Positions_Redis_MT4AUKC01_3006_20141105_151028.xlsx | H:\Downloads\Positions_Database_ars_AUKC01_6_20141105_151030.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKC02_3046_20141105_151508.xlsx | H:\Downloads\Positions_Database_ars_AUKC02_46_20141105_151452.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                | ArsPositionsFile                                                    |
	| H:\Downloads\Positions_Redis_MT4AUKB2B1_3074_20141105_162851.xlsx | H:\Downloads\Positions_Database_ars_AUKB2B1_74_20141105_162852.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
#Scenario: Compare JPN Client Positions
#	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
#	| server1 | server2  | Database1 | Database2 | Connection1 | Connection2                |
#	| JPN     | MT4JPC01 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
#	Then the redis positions should match the ars positions exactly:-
#		| ExportType     |  Overwrite |
#		| DataTableToCsv |  true      |
#

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKCBJ_3057_20141105_162555.xlsx | H:\Downloads\Positions_Database_ars_cboj_57_20141105_162554.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKM01_3047_20141105_153940.xlsx | H:\Downloads\Positions_Database_ars_aukm01_47_20141105_153940.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKM02_3048_20141105_154117.xlsx | H:\Downloads\Positions_Database_ars_aukm02_48_20141105_154115.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKP01_3049_20141105_161007.xlsx | H:\Downloads\Positions_Database_ars_AUKP01_49_20141105_161005.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                   | ArsPositionsFile                                                       |
	| H:\Downloads\Positions_Redis_MT4AUKMARKET1_3089_20141105_163035.xlsx | H:\Downloads\Positions_Database_ars_AUKMarket1_89_20141105_163055.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                      | ArsPositionsFile                                                          |
	| H:\Downloads\Positions_Redis_MT4AUKMARKETMENA_3090_20141105_165944.xlsx | H:\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141105_165944.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKMARKETMENA2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                      | ArsPositionsFile                                                          |
	| H:\Downloads\Positions_Redis_MT4AUKMARKETMENA_3090_20141105_172100.xlsx | H:\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141105_172104.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                               | ArsPositionsFile                                                   |
	| H:\Downloads\Positions_Redis_MT4AUKSB1_3053_20141105_161250.xlsx | H:\Downloads\Positions_Database_ars_AUKSB1_53_20141105_161256.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |