# WorkStation 

admin_local:P@ssw0rdABC


## Join To the Domain

Before using the "Access Work or School" feature form the the WorkStation, you need to change the DNS address to you Domain Controller.  
```shell
Get-DnsClientServerAddress
Set-DnsClientServerAddress -InterfaceIndex 3 -ServerAddresses 192.168.100.50
```

Once it is done, you just need to search "Access Work or Schooll" feature on task bar and then use the domain name as local domain.

Or you can use this command :  
```shell
Add-Computer -DomainName nerv.com -Credential nerv\Administrateur -Force -Restart
```