PS C:\Users\Administrator>
PS C:\Users\Administrator> Get-ADDomain


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300146667-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300146667-00,DC=local
DistinguishedName                  : DC=DC300146667-00,DC=local
DNSRoot                            : DC300146667-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300146667-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300146667-00,DC=local
Forest                             : DC300146667-00.local
InfrastructureMaster               : DC300146667.DC300146667-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300146667-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300146667-00,DC=local
ManagedBy                          :
Name                               : DC300146667-00
NetBIOSName                        : DC300146667-00
ObjectClass                        : domainDNS
ObjectGUID                         : dd96eaf9-66c1-48da-b87c-6bd216947ae0
ParentDomain                       :
PDCEmulator                        : DC300146667.DC300146667-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300146667-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300146667.DC300146667-00.local}
RIDMaster                          : DC300146667.DC300146667-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300146667-00,DC=local, DC=DomainDnsZones,DC=DC300146667-00,DC=local,
                                     CN=Configuration,DC=DC300146667-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300146667-00,DC=local
UsersContainer                     : CN=Users,DC=DC300146667-00,DC=local



PS C:\Users\Administrator> Get-ADForest


ApplicationPartitions : {DC=ForestDnsZones,DC=DC300146667-00,DC=local, DC=DomainDnsZones,DC=DC300146667-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300146667.DC300146667-00.local
Domains               : {DC300146667-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300146667.DC300146667-00.local}
Name                  : DC300146667-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300146667-00,DC=local
RootDomain            : DC300146667-00.local
SchemaMaster          : DC300146667.DC300146667-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}



PS C:\Users\Administrator>

