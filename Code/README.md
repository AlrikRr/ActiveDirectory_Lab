# Code and Automate Scripts

## Session and File transfer

Before doing anything, save a PSSession into a variable and use it to copy stuff from Management Machine to DC01
```shell
# Save PSSEssion into $dc
$dc = New-PSSession 192.168.100.50 -Credential (Get-Credential)
# Copy File into DC01
 Copy-Item .\Code\base.json -ToSession $dc C:\Users\Administrateur\Documents\CODE

```

## Data

All the files related to the user generation are stored inside `\data`.  
This folder contains list of firstnames, lastnames, groups & passwords (From rockyou.txt)  