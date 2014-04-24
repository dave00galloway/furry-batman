Feature: CryptoTests
	In order to protect passwords
	As a concerned it user
	I want to be able to secure my credentials

@mytag
Scenario: Encypt and Decrypt Password
	Given my unencypted password is "password"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "password"

Scenario: Encypt and Decrypt complex Password
	Given my unencypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"

Scenario: Direct Encypt and Decrypt Password
	Given my unencrypted password is "password"
	When I directly encrypt my password
	And I directly decrypt the encrypted password
	Then the decrypted password is "password"

Scenario: Direct Encypt and Decrypt complex Password
	Given my unencypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"