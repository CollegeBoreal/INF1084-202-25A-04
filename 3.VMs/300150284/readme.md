Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.
                                                                                                                        Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows                                                                                                                                                       PS C:\Users\Administrator> get-addomain                                                                                 

AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300150284-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150284-00,DC=local
DistinguishedName                  : DC=DC300150284-00,DC=local
DNSRoot                            : DC300150284-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150284-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150284-00,DC=local
Forest                             : DC300150284-00.local
InfrastructureMaster               : DC300150284.DC300150284-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300150284-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150284-00,DC=local
ManagedBy                          :
Name                               : DC300150284-00
NetBIOSName                        : DC300150284-00
ObjectClass                        : domainDNS
ObjectGUID                         : c4cbb4bc-4370-4ad8-9b65-d07901f8b66e
ParentDomain                       :
PDCEmulator                        : DC300150284.DC300150284-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150284-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300150284.DC300150284-00.local}
RIDMaster                          : DC300150284.DC300150284-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150284-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300150284-00,DC=local,
                                     CN=Configuration,DC=DC300150284-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300150284-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150284-00,DC=local



PS C:\Users\Administrator> get-adforest


ApplicationPartitions : {DC=DomainDnsZones,DC=DC300150284-00,DC=local, DC=ForestDnsZones,DC=DC300150284-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300150284.DC300150284-00.local
Domains               : {DC300150284-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300150284.DC300150284-00.local}
Name                  : DC300150284-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300150284-00,DC=local
RootDomain            : DC300150284-00.local
SchemaMaster          : DC300150284.DC300150284-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
