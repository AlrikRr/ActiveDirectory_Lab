# Management Machine
This machine is used to setup and config the AD as a management computer, not linked to the domain.

It will be used to create scripts, remote access to the DC, etc.

## Remote Session to the DC

We are going to use PSSESSION to manage remotly the DC.
First you need to ad the DC ip in the trusted hosts list:  
```shell
Start-Service WinRM
Set-Item WSMan:localhost\client\trustedhosts -Value 192.168.100.50
```
Next, start a new session using:  
```shell
New-PSSession -COmputerName 192.168.100.50 -Credential (Get-Credential)
Enter-PSSession <ID>
```

Add the ID of the PSSession.
