# WorkStation WS01.nerv.com 

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

Take a snapshot of the DC01 and the WS01 once it is joined BEFORE adding the random users so you can go back anytime ou want.