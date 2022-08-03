# Domain Controller DC01.NERV.com

- Windows 2022 CORE (No GUI)

Administrateur:P@ssw0rd123!

## Config - Basic

```shell
sconfig
```

- Update Server (6)
- Reboot (13)
- Intall VMWare Tools

```shell
cd D:\
./setup64.exe
```

- Change computer Name (2) --> DC01
- Remove Sconfig at start menu
```shell
Set-SConfig -AutoLaunch $false
```
## Config - Network
Change Network (8)
- Select Network interface 1 (192.168.100.0)
- Change address ( STATIC )
- 192.168.100.50/255.255.255.0/GW:192.168.100.2

Change Network (8)
- Change Default DNS Address
- 192.168.100.50

## Config - AD Setup

Check Windows AD Features

```shell
 Get-WindowsFeature | ? {$_.Name -LIKE "ad*"}
```
Then install the AD features and management tools  
```shell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
Then create your forest
```shell
Import-Module ADDSDeployment
Install-ADDSForest
```
Press Y then the forest name, here nerv.com and then the same password as the current Adminitrator.
Press Y Again

Once the server reboot, you need to change the DNS and add the IP of the DC (Like we did before but since we install the domain, the DNS was changed).  

### Change IP From Command Line
Rather than using sconfig you can change the IP and the DNS address using PowerShell Commands

First you need to get the InterfaceIndex (In my case 3):  
```shell
Get-NetIPAddress -IPAddress 192.168.100.50
#OR
Get-DnsClientServerAddress
```
## Remove Password COmplexity

```shell
secedit /export /cfg c:\secpol.cfg
(gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
rm -force c:\secpol.cfg -confirm:$false
```