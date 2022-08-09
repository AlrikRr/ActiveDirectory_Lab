# ActiveDiretory_Lab

⚠ Work in progress !


Active DIrectory Lab for Pentesting Practice

Thanks to [@johnHammond](https://github.com/JohnHammond)


## Lab Setup 

1. Domain Controller - DC01.NERV.COM
	- Interface 1 : 192.168.100.50/24 (NAT Network - vmware)
	- Interface 2 : 192.168.2.50/24 (Bridge Network - Local)


## Users Creation

1. \Code\gen_random_users.ps1 : RUn this script to generate a JSON file with random groups and random users

```shell
gen_random_users.ps1 -outJSONFile base.json
```

2. \Code\ad_users.ps1 : Run this script on your DC with the new JSON file to add everything in the Domain

```shell
ad_users.ps1 -JsonFile base.json
```
