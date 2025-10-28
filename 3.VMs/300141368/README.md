$env:COMPUTERNAME
DC300141368 

[System.Net.Dns]::GetHostName()
>> [System.Net.Dns]::GetHostEntry("localhost").HostName
DC300141368
DC300141368.DC300141368-00.local

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             NoChangeNeeded {}

 Get-ADDomainController -Discover | Select-Object Name,HostName,Site                          
Name        HostName                           Site
----        --------                           ----
DC300141368 {DC300141368.DC300141368-00.local} Default-First-Site-Name

 Get-ADDomain
>> Get-ADForest


AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300141368-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300141368-00,DC=local
DistinguishedName                  : DC=DC300141368-00,DC=local
DNSRoot                            : DC300141368-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300141368-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300141368-00,DC=local
Forest                             : DC300141368-00.local
InfrastructureMaster               : DC300141368.DC300141368-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300141368-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300141368-00,DC=local
ManagedBy                          :
Name                               : DC300141368-00
NetBIOSName                        : DC300141368-00
ObjectClass                        : domainDNS
ObjectGUID                         : 030a6ae2-9062-4dd3-997a-fae7d2eda4c0
ParentDomain                       :
PDCEmulator                        : DC300141368.DC300141368-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300141368-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300141368.DC300141368-00.local}
RIDMaster                          : DC300141368.DC300141368-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300141368-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300141368-00,DC=local,
                                     CN=Configuration,DC=DC300141368-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300141368-00,DC=local
UsersContainer                     : CN=Users,DC=DC300141368-00,DC=local

ApplicationPartitions : {DC=ForestDnsZones,DC=DC300141368-00,DC=local, DC=DomainDnsZones,DC=DC300141368-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300141368.DC300141368-00.local
Domains               : {DC300141368-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300141368.DC300141368-00.local}
Name                  : DC300141368-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300141368-00,DC=local
RootDomain            : DC300141368-00.local
SchemaMaster          : DC300141369.DC300141368-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}


[System.Net.Dns]::GetHostName()
>> [System.Net.Dns]::GetHostEntry("localhost").HostName
DC300141368
DC300141368.DC300141368-00.local

Get-ADDomainController -Discover | Select-Object Name,HostName,Site

Name        HostName                           Site
----        --------                           ----
DC300141368 {DC300141368.DC300141368-00.local} Default-First-Site-Name


Get-ComputerInfo | Select-Object CsName,DnsHostName

CsName      DnsHostName
------      -----------
DC300141368

