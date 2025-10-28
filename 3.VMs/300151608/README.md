AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=dc300151608,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=dc300151608,DC=local
DistinguishedName                  : DC=dc300151608,DC=local
DNSRoot                            : dc300151608.local
DomainControllersContainer         : OU=Domain Controllers,DC=dc300151608,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=dc300151608,DC=local
Forest                             : dc300151608.local
InfrastructureMaster               : DC300151608.dc300151608.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=dc300151608,DC
                                     =local}
LostAndFoundContainer              : CN=LostAndFound,DC=dc300151608,DC=local
ManagedBy                          :
Name                               : dc300151608
NetBIOSName                        : B3001516
ObjectClass                        : domainDNS
ObjectGUID                         : 2acb57ea-9902-471d-9821-f75315545efe
ParentDomain                       :
PDCEmulator                        : DC300151608.dc300151608.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=dc300151608,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300151608.dc300151608.local}
RIDMaster                          : DC300151608.dc300151608.local
SubordinateReferences              : {DC=ForestDnsZones,DC=dc300151608,DC=local,
                                     DC=DomainDnsZones,DC=dc300151608,DC=local,
                                     CN=Configuration,DC=dc300151608,DC=local}
SystemsContainer                   : CN=System,DC=dc300151608,DC=local
UsersContainer                     : CN=Users,DC=dc300151608,DC=local



PS C:\Users\Administrator> Get-ADForest


ApplicationPartitions : {DC=DomainDnsZones,DC=dc300151608,DC=local, DC=ForestDnsZones,DC=dc300151608,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300151608.dc300151608.local
Domains               : {dc300151608.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300151608.dc300151608.local}
Name                  : dc300151608.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=dc300151608,DC=local
RootDomain            : dc300151608.local
SchemaMaster          : DC300151608.dc300151608.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
