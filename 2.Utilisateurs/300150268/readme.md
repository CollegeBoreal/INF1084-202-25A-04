PS C:\Users\Administrator> get-addomain                                                                                 

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300150268-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150268-00,DC=local
DistinguishedName                  : DC=DC300150268-00,DC=local
DNSRoot                            : DC300150268-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150268-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150268-00,DC=local
Forest                             : DC300150268-00.local
InfrastructureMaster               : DC300150268.DC300150268-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300150268-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150268-00,DC=local
ManagedBy                          :
Name                               : DC300150268-00
NetBIOSName                        : DC300150268-00
ObjectClass                        : domainDNS
ObjectGUID                         : 5e760b60-01e0-4403-9ca9-b6bfe9a0c62e
ParentDomain                       :
PDCEmulator                        : DC300150268.DC300150268-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150268-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300150268.DC300150268-00.local}
RIDMaster                          : DC300150268.DC300150268-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150268-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300150268-00,DC=local,
                                     CN=Configuration,DC=DC300150268-00,DC=local}


PS C:\Users\Administrator> get-adforest


ApplicationPartitions : {DC=ForestDnsZones,DC=DC300150268-00,DC=local, DC=DomainDnsZones,DC=DC300150268-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300150268.DC300150268-00.local
Domains               : {DC300150268-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300150268.DC300150268-00.local}
Name                  : DC300150268-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300150268-00,DC=local
RootDomain            : DC300150268-00.local
SchemaMaster          : DC300150268.DC300150268-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
                                     
SystemsContainer                   : CN=System,DC=DC300150268-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150268-00,DC=local
