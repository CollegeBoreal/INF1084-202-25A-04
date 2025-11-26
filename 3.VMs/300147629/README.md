# voici la commande de l’installations
Install-WindowsFeature AD-Domain-Services –IncludeManagementTools

<img width="797" height="228" alt="Vm2 png" src="https://github.com/user-attachments/assets/c6e8921c-4a98-4c61-bfea-202b43ad0f1f" />


--------------------------------

```powershell
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

-----------------------
# verification de l'installations
</detail>

<img width="1305" height="702" alt="Vm1 png" src="https://github.com/user-attachments/assets/cbf4589c-a49a-4c96-9275-80a27366af57" />
  #voici la commande pour verifier

Get-ADDomain
Get-ADForest

```powershell

PS C:\Users\Administrator> Get-ADDomain                                                                                 >> Get-ADForest                                                                                                         

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300147629-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300147629-00,DC=local
DistinguishedName                  : DC=DC300147629-00,DC=local
DNSRoot                            : DC300147629-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300147629-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300147629-00,DC=local
Forest                             : DC300147629-00.local
InfrastructureMaster               : DC300147629.DC300147629-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300147629-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300147629-00,DC=local
ManagedBy                          :
Name                               : DC300147629-00
NetBIOSName                        : DC300147629-00
ObjectClass                        : domainDNS
ObjectGUID                         : e86e0afd-3e14-4f06-b5d2-fcd54a92fab3
ParentDomain                       :
PDCEmulator                        : DC300147629.DC300147629-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300147629-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300147629.DC300147629-00.local}
RIDMaster                          : DC300147629.DC300147629-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300147629-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300147629-00,DC=local,
                                     CN=Configuration,DC=DC300147629-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300147629-00,DC=local
UsersContainer                     : CN=Users,DC=DC300147629-00,DC=local

ApplicationPartitions : {DC=DomainDnsZones,DC=DC300147629-00,DC=local, DC=ForestDnsZones,DC=DC300147629-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300147629.DC300147629-00.local
Domains               : {DC300147629-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300147629.DC300147629-00.local}
Name                  : DC300147629-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300147629-00,DC=local
RootDomain            : DC300147629-00.local
SchemaMaster          : DC300147629.DC300147629-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
```
----------------------------



