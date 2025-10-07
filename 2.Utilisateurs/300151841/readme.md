Administrator> Get-ADDomain

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300151841-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300151841-00,DC=local
DistinguishedName                  : DC=DC300151841-00,DC=local
DNSRoot                            : DC300151841-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300151841-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300151841-00,DC=local
Forest                             : DC300151841-00.local
InfrastructureMaster               : DC300151841.DC300151841-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300151841-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300151841-00,DC=local
ManagedBy                          :
Name                               : DC300151841-00
NetBIOSName                        : DC300151841-00
ObjectClass                        : domainDNS
ObjectGUID                         : 3d4bb400-ea5d-4d25-8954-df87b9b858d7
ParentDomain                       :
PDCEmulator                        : DC300151841.DC300151841-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300151841-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300151841.DC300151841-00.local}
RIDMaster                          : DC300151841.DC300151841-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300151841-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300151841-00,DC=local,
                                     CN=Configuration,DC=DC300151841-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300151841-00,DC=local
UsersContainer                     : CN=Users,DC=DC300151841-00,DC=local




PS C:\Users\Administrator> Get-ADForest


ApplicationPartitions : {DC=DomainDnsZones,DC=DC300151841-00,DC=local, DC=ForestDnsZones,DC=DC300151841-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300151841.DC300151841-00.local
Domains               : {DC300151841-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300151841.DC300151841-00.local}
Name                  : DC300151841-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300151841-00,DC=local
RootDomain            : DC300151841-00.local
SchemaMaster          : DC300151841.DC300151841-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
