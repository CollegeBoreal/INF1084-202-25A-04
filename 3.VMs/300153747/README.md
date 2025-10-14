# 300153747

<details>

```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```
</details>

```powershell
Install-ADDSForest `
    -DomainName "DC300153747-00.local" `
    -DomainNetbiosName "DC300153747-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
```powershell
PS C:\Users\Administrator> Get-ADDomain
>>


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300153747-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300153747-00,DC=local
DistinguishedName                  : DC=DC300153747-00,DC=local
DNSRoot                            : DC300153747-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300153747-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300153747-00,DC=local
Forest                             : DC300153747-00.local
InfrastructureMaster               : DC300153747.DC300153747-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=S
                                     ystem,DC=DC300153747-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300153747-00,DC=local
ManagedBy                          :
Name                               : DC300153747-00
NetBIOSName                        : DC300153747-00
ObjectClass                        : domainDNS
ObjectGUID                         : c9a9901c-afe6-4495-8270-3faecfd24314
ParentDomain                       :
PDCEmulator                        : DC300153747.DC300153747-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300153747-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300153747.DC300153747-00.local}
RIDMaster                          : DC300153747.DC300153747-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300153747-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300153747-00,DC=local,
                                     CN=Configuration,DC=DC300153747-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300153747-00,DC=local
UsersContainer                     : CN=Users,DC=DC300153747-00,DC=local
```
