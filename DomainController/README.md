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

