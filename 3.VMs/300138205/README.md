# 300138205
# INF1084 – Administration Windows  
## Participation Active Directory  
**Nom :** Taylor  
**Matricule :** 300138205 
**Date :** 26 octobre 2025  

---

### 🧩 Installation et configuration du domaine Active Directory

#### Domaine créé
- Nom du domaine : `DC300138205-00.local`
- Contrôleur de domaine : `DC300138205`
- DNS intégré et fonctionnel ✅

#### Étapes réalisées
1. Installation du rôle AD DS  
2. Création du domaine `DC300138205-00.local`  
3. Création des OU :  
   - `Informatique`  
   - `Comptabilité`  
4. Création des utilisateurs :  
   - Alice Dupont (adupont)  
   - Bob Martin (bmartin)  
5. Création du groupe `Techniciens` et ajout de `adupont`  
6. Vérification via PowerShell (`Get-ADUser`, `Get-ADOrganizationalUnit`) ✅  

---

```powershell
Rename-Computer -NewName "DC300138205" -Restart
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
ComputersContainer                 : CN=Computers,DC=DC300138205-00,DC=local
DeletedObjectsContainer            : CN=Deleted Objects,DC=DC300138205-00,DC=local
DistinguishedName                  : DC=DC300138205-00,DC=local
DNSRoot                            : DC300138205-00.local
DomainControllersContainer         : OU=Domain Controllers,DC=DC300138205-00,DC=local
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-447135690-91861430-3213525697
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=DC300138205-00,DC=local
Forest                             : DC300138205-00.local
InfrastructureMaster               : DC300138205.DC300138205-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300138205-00
                                     ,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300138205-00,DC=local
ManagedBy                          :
Name                               : DC300138205-00
NetBIOSName                        : DC300138205-00
ObjectClass                        : domainDNS
ObjectGUID                         : 762f2b48-649f-4fab-ad85-74a83a1144cd
ParentDomain                       :
PDCEmulator                        : DC300138205.DC300138205-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300138205-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300138205.DC300138205-00.local}
RIDMaster                          : DC300138205.DC300138205-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300138205-00,DC=local,
                                     DC=DomainDnsZones,DC=DC300138205-00,DC=local,
                                     CN=Configuration,DC=DC300138205-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300138205-00,DC=local
UsersContainer                     : CN=Users,DC=DC300138205-00,DC=local


```

</details>


```powershell

Get-ADForest
```

<details>


``` powershell




ApplicationPartitions : {DC=ForestDnsZones,DC=DC300138205-00,DC=local, DC=DomainDnsZones,DC=DC300138205-00,DC=local}
CrossForestReferences : {}
DomainNamingMaster    : DC300138205.DC300138205-00.local
Domains               : {DC300138205-00.local}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC300138205.DC300138205-00.local}
Name                  : DC300138205-00.local
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=DC300138205-00,DC=local
RootDomain            : DC300138205-00.local
SchemaMaster          : DC300138205.DC300138205-00.local
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}

```

</details>


