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

Scenario: Direct Decrypt complex Password
	Given my encrypted password is "1-0-0-0-208-140-157-223-1-21-209-17-140-122-0-192-79-194-151-235-1-0-0-0-13-245-5-48-90-188-159-68-139-87-217-81-43-30-196-135-0-0-0-0-2-0-0-0-0-0-3-102-0-0-192-0-0-0-16-0-0-0-55-80-201-201-1-50-209-112-34-132-130-147-230-183-100-118-0-0-0-0-4-128-0-0-160-0-0-0-16-0-0-0-93-51-247-192-205-5-134-215-44-213-61-184-232-21-130-192-72-0-0-0-241-90-230-235-188-172-166-89-249-171-59-98-199-126-142-87-185-176-247-34-152-255-165-99-62-252-153-246-86-217-198-162-189-64-222-163-176-135-33-241-209-68-236-146-8-216-80-7-9-120-39-18-35-72-223-147-153-104-66-232-39-201-212-166-77-63-252-171-61-149-25-137-20-0-0-0-130-229-133-157-179-54-159-143-162-94-7-224-39-234-16-57-171-23-215-212"
	When I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
