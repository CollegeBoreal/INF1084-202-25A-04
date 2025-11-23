<<<<<<< 300141429
# 300141429 Installation ADDS


```powershell
Commande pour renommer le serveur
```
<details>
  
  ```powershell
  Rename-Computer -NewName "DC300141429" -Restart
  ```
</details>
  
```powershell
Installer le role ADDS
```

<details>
  
```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Active Directory Domain Services, Group P...
```

</details>

```powershell
Creation du domaine:  
```
<details>

  ```powershell
`Install-ADDSForest
    -DomainName "DC300141429.local" `
    -DomainNetbiosName "DC999999999-00" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDSRM123!" -AsPlainText -Force) `
    -Force
```
 </details>

```powershell
 Verification du domaine
```
<details>

```powershell
Get-ADDomain
AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=DC300141429,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300141429,DC=local
DistinguishedName                  : DC=DC300141429,DC=local
DNSRoot                            : DC300141429.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300141429,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300141429,DC=local
Forest                             : DC300141429.local
InfrastructureMaster               : DC300141429.DC300141429.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300141429,DC
                                     =local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300141429,DC=local
ManagedBy                          :
Name                               : DC300141429
NetBIOSName                        : DC999999999-00
ObjectClass                        : domainDNS
ObjectGUID                         : 8d4493b3-3faf-42d9-9b53-043f9471b2ec
ParentDomain                       :
PDCEmulator                        : DC300141429.DC300141429.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300141429,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300141429.DC300141429.local}
RIDMaster                          : DC300141429.DC300141429.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300141429,DC=local,
                                     DC=DomainDnsZones,DC=DC300141429,DC=local,
                                     CN=Configuration,DC=DC300141429,DC=local}
SystemsContainer                   : CN=System,DC=DC300141429,DC=local
UsersContainer                     : CN=Users,DC=DC300141429,DC=local

```

</details>

```powershell
  Verification de la foret
```

<details>

```powershell
Get-ADForest
ApplicationPartitions : {DC=ForestDnsZones,DC=DC300141429,DC=local, DC=DomainDnsZones,DC=DC300141429,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300141429.DC300141429.local
Domains               : {DC300141429.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300141429.DC300141429.local}
Name                  : DC300141429.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300141429,DC=local
RootDomain            : DC300141429.local
SchemaMaster          : DC300141429.DC300141429.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}

```


  
</details>
=======
#300141429
>>>>>>> main
