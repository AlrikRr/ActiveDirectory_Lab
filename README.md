# ActiveDiretory_Lab
Active DIrectory Lab for Pentesting Practice

Thanks to [@johnHammond](https://github.com/JohnHammond)


Lab Setup :

1. Domain Controller - DC01.NERV.COM
	- Interface 1 : 192.168.100.50/24 (NAT Network - vmware)
	- Interface 2 : 192.168.2.50/24 (Bridge Network - Local)

Script to run :

1. gen_random_users.ps1 : RUn this script to generate a JSON file with random groups and random users
2. ad_users.ps1 : Run this script with the new JSON file to add everything in the Domain
	- This will change the password policy 

	