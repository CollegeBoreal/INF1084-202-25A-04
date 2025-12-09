

# Projet final Active Directory : Trusts entre deux domains
### Etudiants : Madjou (300153747) , Danialla (300141368)
### Cours : INF1084 – Administration Windows Server

---

## Objectif du laboratoire

Ce laboratoire a pour objectif de vérifier la communication et l’accès entre deux contrôleurs de domaine :

- Vérifier la connectivité réseau entre les domaines  
- Récupérer les informations du domaine distant  
- Naviguer dans l’Active Directory distant

---

## 🔐 Définition d’un Trust dans AD DS

Une relation d’approbation (trust) dans Active Directory est un lien d’authentification sécurisé entre deux domaines ou forêts permettant aux utilisateurs d’un domaine d’accéder aux ressources d’un autre domaine.

---

#  le script  trusts.ps1

Dans ce laboration, nous avons realisé un trust unidirectionnel et celui qui a fait cette action est le serveur 10.7.236.188 ( DC300138205-00)

```powershell
trusts.ps1
```

<details>

  

<img src="images/Screenshot 2025-12-04 150356.png" alt="Girl in a jacket" width="500" height="600">

<img src="images/Screenshot 2025-12-04 152019.png" alt="Girl in a jacket" width="500" height="600">
</details>

### **b. Vérifieons la connectivité au contrôleur de domaine DC300141429**

```powershell
Test-Connection -ComputerName DC300141369.local -Count 2
```

<img src="images/Screenshot 2025-12-04 151910.png" alt="Girl in a jacket" width="500" height="600">



---
``` powershell
trusts2.ps1
```
<details>
 PS C:\Users\Public\developper\INF1084-202-25A-04\7.DCs\300141368-300153747> .\trusts2.ps1
=== VÃ©rification du Trust entre les deux forÃªts ===

Ã‰tape 1 : Entrer les identifiants AD2...

Ã‰tape 2 : Test de connectivitÃ© vers DC2...

Source        Destination     IPV4Address      IPV6Address                              Bytes    Time(ms)
------        -----------     -----------      -----------                              -----    --------
DC300153747   DC300141369.... 10.7.236.189                                              32       1
DC300153747   DC300141369.... 10.7.236.189                                              32       1

Ã‰tape 3 : Informations sur le domaine AD2...

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
InfrastructureMaster               : DC300141369.DC300141368-00.local
LastLogonReplicationInterval       :
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=DC300141368-00,DC=local}
LostAndFoundContainer              : CN=LostAndFound,DC=DC300141368-00,DC=local                                                                                                                    ManagedBy                          :                                                                                                                                                               Name                               : DC300141368-00                                                                                                                                                NetBIOSName                        : DC300141368-00                                                                                                                                                ObjectClass                        : domainDNS                                                                                                                                                     ObjectGUID                         : 030a6ae2-9062-4dd3-997a-fae7d2eda4c0
ParentDomain                       :
PDCEmulator                        : DC300141369.DC300141368-00.local
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=DC300141368-00,DC=local
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC300141369.DC300141368-00.local}
RIDMaster                          : DC300141369.DC300141368-00.local
SubordinateReferences              : {DC=ForestDnsZones,DC=DC300141368-00,DC=local, DC=DomainDnsZones,DC=DC300141368-00,DC=local, CN=Configuration,DC=DC300141368-00,DC=local}
SystemsContainer                   : CN=System,DC=DC300141368-00,DC=local
UsersContainer                     : CN=Users,DC=DC300141368-00,DC=local


Ã‰tape 4 : Liste des utilisateurs AD2...

Name           : Administrator
SamAccountName : Administrator


Name           : Guest
SamAccountName : Guest


Name           : student1
SamAccountName : student1


Name           : krbtgt
SamAccountName : krbtgt


Ã‰tape 5 : CrÃ©ation du PSDrive AD2...

Server                       :
FormatType                   : X500
AuthType                     : Negotiate
GlobalCatalog                : False
SecureSocketLayer            : False
Encryption                   : True
Signing                      : True
RootWithoutAbsolutePathToken : DC=DC300153747-00,DC=local
CurrentLocation              :
Name                         : AD2
Provider                     : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
Root                         : //RootDSE/DC=DC300153747-00,DC=local
Description                  :
MaximumSize                  :
Credential                   : System.Management.Automation.PSCredential
DisplayRoot                  :
Used                         :
Free                         :

Navigation dans AD2...
Liste des OU de AD2 :

PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Builtin,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Builtin
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Builtin,DC=DC300153747-00,DC=local
name               : Builtin
objectClass        : builtinDomain
objectGUID         : 22897d6d-9b62-4a55-bf57-07892719871e
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Computers,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Computers
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Computers,DC=DC300153747-00,DC=local
name               : Computers
objectClass        : container
objectGUID         : cb1b6159-6730-420c-8f73-3367d39ef2b7
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/OU=Domain Controllers,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : OU=Domain Controllers
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : OU=Domain Controllers,DC=DC300153747-00,DC=local
name               : Domain Controllers
objectClass        : organizationalUnit
objectGUID         : d9709e5b-9582-4523-abc8-b65bc4ed4096
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=ForeignSecurityPrincipals,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=ForeignSecurityPrincipals
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=ForeignSecurityPrincipals,DC=DC300153747-00,DC=local
name               : ForeignSecurityPrincipals
objectClass        : container
objectGUID         : 9b474322-fa87-4aa1-9d07-6a3b08c692ca
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Infrastructure,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Infrastructure
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Infrastructure,DC=DC300153747-00,DC=local
name               : Infrastructure
objectClass        : infrastructureUpdate
objectGUID         : 38766d36-ebfe-4a79-a090-dab14456dca0
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Keys,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Keys
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Keys,DC=DC300153747-00,DC=local
name               : Keys
objectClass        : container
objectGUID         : 6a69efbb-81d4-4545-880b-ce67643be4d4
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=LostAndFound,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=LostAndFound
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=LostAndFound,DC=DC300153747-00,DC=local
name               : LostAndFound
objectClass        : lostAndFound
objectGUID         : d444c954-657a-44ad-afca-a43ddb1599e9
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Managed Service Accounts,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Managed Service Accounts
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Managed Service Accounts,DC=DC300153747-00,DC=local
name               : Managed Service Accounts
objectClass        : container
objectGUID         : e365d8c7-9f18-45d1-99ef-06a77058fdf9
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=NTDS Quotas,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=NTDS Quotas
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=NTDS Quotas,DC=DC300153747-00,DC=local
name               : NTDS Quotas
objectClass        : msDS-QuotaContainer
objectGUID         : 710bf2a3-43e8-4ffc-b0b6-863e18556529
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Program Data,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Program Data
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Program Data,DC=DC300153747-00,DC=local
name               : Program Data
objectClass        : container
objectGUID         : 89038c94-f745-4eab-99a2-3bbd485cae33
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/OU=Students,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : OU=Students
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : OU=Students,DC=DC300153747-00,DC=local
name               : Students
objectClass        : organizationalUnit
objectGUID         : af94b17b-2690-4f51-b7b5-ffa6e2082a96
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=System,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=System
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=System,DC=DC300153747-00,DC=local
name               : System
objectClass        : container
objectGUID         : 0f244934-ea70-45a1-a4f1-aa3aa8fac340
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=TPM Devices,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=TPM Devices
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=TPM Devices,DC=DC300153747-00,DC=local
name               : TPM Devices
objectClass        : msTPM-InformationObjectsContainer
objectGUID         : bb1aee43-24fa-4ec0-bca0-b4a55fd61181
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


PSPath             : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/CN=Users,DC=DC300153747-00,DC=local
PSParentPath       : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory:://RootDSE/DC=DC300153747-00,DC=local
PSChildName        : CN=Users
PSDrive            : AD2
PSProvider         : Microsoft.ActiveDirectory.Management.dll\ActiveDirectory
PSIsContainer      : True
distinguishedName  : CN=Users,DC=DC300153747-00,DC=local
name               : Users
objectClass        : container
objectGUID         : ddaaebbc-8f94-4900-8753-4dffc156e053
PropertyNames      : {distinguishedName, name, objectClass, objectGUID...}
AddedProperties    : {}
RemovedProperties  : {}
ModifiedProperties : {}
PropertyCount      : 5


Ã‰tape 6 : VÃ©rification du Trust configurÃ©...



Name                     Direction TrustType ForestTransitive
----                     --------- --------- ----------------
DC300141368-00.local BiDirectional       MIT            False



=== VÃ©rification terminÃ©e ===
</details>







