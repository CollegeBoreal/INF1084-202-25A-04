# TP Active Directory (AD DS) – Windows Server  
**Nom et prénom: Akrem Bouraoui**  
**ID : 300150527**

------------------------------

## 📌 Introduction

Ce laboratoire a pour objectif d’installer, configurer et vérifier un contrôleur de domaine Active Directory (AD DS) en utilisant Windows Server 2022.  
Le travail consiste également à exécuter des commandes PowerShell permettant de confirmer la bonne création du domaine, de la forêt, et du contrôleur AD.

Ce README résume les étapes principales et inclut des captures d’écran réalisées sur mon environnement VM.

---------------------------------

## 🧩 Objectifs du TP

- Comprendre les concepts essentiels d’Active Directory : domaine, forêt, OU, DNS, SYSVOL.
- Installer le rôle AD DS sur Windows Server.
- Promouvoir le serveur en contrôleur de domaine.
- Vérifier l’installation via **Get-ADDomain** et **Get-ADForest**.
- Documenter le tout avec des captures d’écran.

-----------------------------

## 🏗️ 1. Installation du rôle AD DS

Après connexion au serveur, le rôle AD DS a été installé via Server Manager.

<img width="656" height="106" alt="1" src="https://github.com/user-attachments/assets/c3a5abd7-32e7-4514-ad9b-6d3f7642b70b" />


---------------------------


<img width="1366" height="713" alt="ADDS" src="https://github.com/user-attachments/assets/963a6815-7922-4428-8949-d0767a16c6cc" />


------------------------------

## 🏰 2. Vérification du domaine Active Directory

- Une fois le serveur promu comme contrôleur de domaine, la commande suivante a été exécutée :

**Get-ADDomain**

Cette commande permet d’afficher les informations liées au domaine :

- DistinguishedName
- DomainSID
- DomainMode
- Containers AD par défaut (Computers, Users…)
- PDC Emulator
- Domain Naming Master

<img width="1366" height="707" alt="GET-ADDomain" src="https://github.com/user-attachments/assets/6366c813-c192-41ba-bb67-f461868ebf1d" />

-------------------------------------------

## 🌲 3. Vérification de la forêt Active Directory

- La commande suivante a été exécutée pour vérifier la forêt :

**Get-ADForest**

Cette commande affiche notamment :

- RootDomain
- Global Catalogs
- Partitions
- Domain Naming Master
- Schema Master
- Sites

<img width="1366" height="728" alt="GET-ADForest" src="https://github.com/user-attachments/assets/04516544-89ee-43e5-861e-18a3f42448e5" />

------------------------------------

## 📁 Structure du dépôt

<img width="239" height="154" alt="dd" src="https://github.com/user-attachments/assets/e9193019-8487-45b6-b90c-1143cc599909" />

---------------------------------

## 🏁 Conclusion
Ce TP m’a permis de comprendre les étapes essentielles de la mise en place d’un contrôleur de domaine Active Directory, ainsi que l’importance du DNS, du SYSVOL et des rôles FSMO.
L’utilisation de PowerShell a simplifié la validation de la configuration AD, confirmant que le domaine et la forêt ont été correctement créés et opérationnels.

--------------------------------------

```powershell
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

------------------------------------------------

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


