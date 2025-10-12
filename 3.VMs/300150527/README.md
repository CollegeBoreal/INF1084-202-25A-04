#AkremBouraoui  #300150527

1 - Fichiers inclus :

- ADDS.PNG
- GET-ADDomain.PNG
- GET-ADForest.PNG
- README.md


2 - Vérification :

Après l'installation, j'ai utilisé les commandes suivantes pour " vérifier que le domaine et la forêt AD DS ont été configurés correctement " :

Sur powershell :

    - Get-ADDomain
    - Get-ADForest

Les résultats de ces commandes sont visibles dans les captures jointes aussi.

----------------------------------------------------------------------------------------------------------------------------------------

PS C:\Users\Administrator> Get-ADDomain


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300150527-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300150527-00,DC=local
DistinguishedName                  : DC=DC300150527-00,DC=local
DNSRoot                            : DC300150527-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300150527-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300150527-00,DC=local
Forest                             : DC300150527-00.local
InfrastructureMaster               : DC300150527.DC300150527-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300150527-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300150527-00,DC=local
ManagedBy                          :
Name                               : DC300150527-00
NetBIOSName                        : DC300150527-00
ObjectClass                        : domainDNS
ObjectGUID                         : 2967c940-4b7b-45a0-a421-e724e5bd1894
ParentDomain                       :
PDCEmulator                        : DC300150527.DC300150527-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300150527-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300150527.DC300150527-00.local}
RIDMaster                          : DC300150527.DC300150527-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300150527-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300150527-00,DC=local,
                                     CN=Configuration,DC=DC300150527-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300150527-00,DC=local
UsersContainer                     : CN=Users,DC=DC300150527-00,DC=local



PS C:\Users\Administrator> Get-ADForest


ApplicationPartitions : {DC=DomainDnsZones,DC=DC300150527-00,DC=local, DC=ForestDnsZones,DC=DC300150527-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300150527.DC300150527-00.local
Domains               : {DC300150527-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300150527.DC300150527-00.local}
Name                  : DC300150527-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300150527-00,DC=local
RootDomain            : DC300150527-00.local
SchemaMaster          : DC300150527.DC300150527-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}






