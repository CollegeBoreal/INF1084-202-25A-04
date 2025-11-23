Techniques des Systèmes Informatiques – Collège Boréal

TP : Installation et Validation d’un Contrôleur de Domaine

👤 Étudiant : Mohammed Aiche

🆔 ID : 300151608

🖥️ Domaine AD : DC300151608-00.local

📅 Session : Automne 2025

⭐ Introduction

Dans ce travail pratique, j’ai installé et configuré un contrôleur de domaine Active Directory sur Windows Server.
L’objectif principal était :

#comprendre les rôles AD DS (Domain Services)

#vérifier l’état du domaine et de la forêt

#utiliser PowerShell pour valider la configuration

#capturer les résultats dans un rapport clair et structuré

Ce TP m’a permis de renforcer ma maîtrise d’Active Directory, de PowerShell et des commandes essentielles pour administrer un domaine professionnel.

🖥️ AD DS – Vérification du serveur

Cette capture montre que le rôle Active Directory Domain Services (AD DS) est installé avec succès.
Le contrôleur de domaine DC300151608 apparaît en état Online, ce qui confirme que le serveur fonctionne correctement et que la configuration est opérationnelle.

<img width="760" height="452" alt="vm1" src="https://github.com/user-attachments/assets/f2a17e1d-d19a-4a9c-a385-7dc95bdb8aa4" />

🔍 Get-ADDomain

Cette capture montre les informations principales du domaine dc300151608.local.
La commande confirme que le domaine est bien configuré et fonctionne correctement.

<img width="769" height="494" alt="vm2" src="https://github.com/user-attachments/assets/9fe9bb48-4905-4e50-b89d-8e80584d890f" />

🌳 Get-ADForest

Cette commande affiche les informations principales de la forêt Active Directory.
Le résultat montre que la forêt dc300151608.local est bien configurée et fonctionnelle.

<img width="602" height="343" alt="vm3" src="https://github.com/user-attachments/assets/889cd310-9e9c-4e46-a6ce-0c20e451b9a3" />





🏁 Conclusion

🎯 Ce TP m’a permis de comprendre toutes les étapes essentielles pour mettre en place un serveur Active Directory fonctionnel.
J’ai appris :

l’importance du rôle AD DS

comment valider un domaine et une forêt via PowerShell

comment analyser les rôles FSMO

comment documenter un environnement serveur avec des captures professionnelles

💡 Grâce à ce travail, j’ai maintenant une meilleure compréhension du fonctionnement interne d’Active Directory et de la manière d’administrer un domaine Windows Server de façon professionnelle.










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
