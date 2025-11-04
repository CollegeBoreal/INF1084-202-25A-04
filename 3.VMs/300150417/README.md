# 300150417


```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

<details>
  
```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

</details>

```powershell
PS C:\Users\Administrator> Get-ADDomain
```
```powershell
PS C:\Users\Administrator> Get-ADForest
```

<details>
  
```powershell

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300150417-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150417-00,DC=local
DistinguishedName                  : DC=DC300150417-00,DC=local
DNSRoot                            : DC300150417-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150417-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150417-00,DC=local
Forest                             : DC300150417-00.local
InfrastructureMaster               : DC30150417.DC300150417-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300150417-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150417-00,DC=local
ManagedBy                          :
Name                               : DC300150417-00
NetBIOSName                        : DC300150417-00
ObjectClass                        : domainDNS
ObjectGUID                         : c2c67d7d-bbd5-4c48-a961-0c402f58a96a
ParentDomain                       :
PDCEmulator                        : DC30150417.DC300150417-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150417-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC30150417.DC300150417-00.local}
RIDMaster                          : DC30150417.DC300150417-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150417-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300150417-00,DC=local,
                                     CN=Configuration,DC=DC300150417-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300150417-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150417-00,DC=local



-----------------------------------------------------------------------------------------------------------

ApplicationPartitions : {DC=ForestDnsZones,DC=DC300150417-00,DC=local, DC=DomainDnsZones,DC=DC300150417-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC30150417.DC300150417-00.local
Domains               : {DC300150417-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC30150417.DC300150417-00.local}
Name                  : DC300150417-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300150417-00,DC=local
RootDomain            : DC300150417-00.local
SchemaMaster          : DC30150417.DC300150417-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}

</details>

