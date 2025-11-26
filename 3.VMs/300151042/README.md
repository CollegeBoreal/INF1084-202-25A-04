# 300151042

```powershell
Rename-Computer -NewName "DC300151042" -Restart
```

<details>

  ```powershell

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...

```

</details>

```powershell
Get-ADDomain
```

<details>


``` powershell


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300151042-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300151042-00,DC=local
DistinguishedName                  : DC=DC300151042-00,DC=local
DNSRoot                            : DC300151042-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300151042-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300151042-00,DC=local
Forest                             : DC300151042-00.local
InfrastructureMaster               : DC300151042.DC300151042-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300151042-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300151042-00,DC=local
ManagedBy                          :
Name                               : DC300151042-00
NetBIOSName                        : DC300151042-00
ObjectClass                        : domainDNS
ObjectGUID                         : 762f2b48-649f-4fab-ad85-74a83a1144cd
ParentDomain                       :
PDCEmulator                        : DC300151042.DC300151042-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300151042-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300151042.DC300151042-00.local}
RIDMaster                          : DC300151042.DC300151042-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300151042-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300151042-00,DC=local,
                                     CN=Configuration,DC=DC300151042-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300151042-00,DC=local
UsersContainer                     : CN=Users,DC=DC300151042-00,DC=local


```

</details>


```powershell

Get-ADForest
```

<details>


``` powershell




ApplicationPartitions : {DC=ForestDnsZones,DC=DC300151042-00,DC=local, DC=DomainDnsZones,DC=DC300151042-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300151042.DC300151042-00.local
Domains               : {DC300151042-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300151042.DC300151042-00.local}
Name                  : DC300151042-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300151042-00,DC=local
RootDomain            : DC300151042-00.local
SchemaMaster          : DC300151042.DC300151042-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}

```

</details>



