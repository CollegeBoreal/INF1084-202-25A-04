# ⭐ 300150395


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
ComputersContainer                 : CN=Computers,DC=DC300150395-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150395-00,DC=local
DistinguishedName                  : DC=DC300150395-00,DC=local
DNSRoot                            : DC300150395-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150395-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150395-00,DC=l
                                     ocal
Forest                             : DC300150395-00.local
InfrastructureMaster               : DC300150395.DC300150395-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Polic
                                     ies,CN=System,DC=DC300150395-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150395-00,DC=local
ManagedBy                          :
Name                               : DC300150395-00
NetBIOSName                        : DC300150395-00
ObjectClass                        : domainDNS
ObjectGUID                         : da0b7949-9036-4132-963a-6a7646a9c2df
ParentDomain                       :
PDCEmulator                        : DC300150395.DC300150395-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150395-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300150395.DC300150395-00.local}
RIDMaster                          : DC300150395.DC300150395-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150395-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300150395-00,DC=local,
                                     CN=Configuration,DC=DC300150395-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300150395-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150395-00,DC=local


---------------------------------------------------------------------------------------------


*ApplicationPartitions : {DC=ForestDnsZones,DC=DC300150395-00,DC=local,
                        DC=DomainDnsZones,DC=DC300150395-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300150395.DC300150395-00.local
Domains               : {DC300150395-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300150395.DC300150395-00.local}
Name                  : DC300150395-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300150395-00,DC=local
RootDomain            : DC300150395-00.local
SchemaMaster          : DC300150395.DC300150395-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
```

</details>

<img width="1919" height="1014" alt="Screenshot-2025-10-07-203028" />


<img src="images/Screenshot-2025-10-07-203028.png" alt="Ma photo" width="300" height="400"/>

<img src="images/Screenshot-2025-10-07-203119.png" alt="Ma photo" width="300" height="400"/>

