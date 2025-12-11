📘 REDAM – Installation et Configuration d’Active Directory Domain Services

Projet : Active Directory – Création de domaine et préparation à une relation de confiance

👤 Informations de l’étudiant

Nom / Prénom : bouras raouf

Numéro étudiant : 300151833

Cours / Module : Active Directory – Administration Windows Server

Environnement : Machine virtuelle Windows Server

Contrôleur de domaine : DC300151833

🎯 Objectif du projet

L’objectif principal de ce projet est de :

Installer et configurer Active Directory Domain Services (AD DS)

Créer un domaine Active Directory fonctionnel

Vérifier la bonne création du domaine et de la forêt

Préparer l’environnement pour une relation de confiance entre forêts (Trust)

🖥️ 1. Renommage du serveur

Avant l’installation d’Active Directory, le serveur doit être renommé afin de respecter les conventions du projet.

✅ Commande utilisée :
Rename-Computer -NewName "DC300151833" -Restart


📌 Cette commande :

Renomme le serveur

Redémarre automatiquement la machine pour appliquer le changement

🧩 2. Installation du rôle AD DS

Le rôle Active Directory Domain Services est requis pour créer un domaine et un contrôleur de domaine.

✅ Commande utilisée :
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools


📌 Cette étape :

Installe AD DS

Installe aussi les outils d’administration

Prépare le serveur à devenir un contrôleur de domaine

🌐 3. Création du domaine Active Directory

Une nouvelle forêt et un nouveau domaine sont créés.

✅ Paramètres du domaine :

Nom du domaine : DC300151833.local

Nom NetBIOS : DC300151833AD

DNS : installé automatiquement

Mot de passe DSRM : défini lors de l’installation

📌 Cette étape transforme le serveur en contrôleur de domaine principal (DC).

🔍 4. Vérification du domaine (Get-ADDomain)
✅ Commande utilisée :
Get-ADDomain

📄 Résultat et description :

DNSRoot : DC300151833.local
→ Nom DNS officiel du domaine

NetBIOSName : DC300151833AD
→ Nom court du domaine (compatibilité Windows)

DistinguishedName :
DC=DC300151833,DC=local
→ Chemin LDAP du domaine

🗂️ Conteneurs système principaux

CN=Users → utilisateurs et groupes par défaut

CN=Computers → ordinateurs joints au domaine

OU=Domain Controllers → contrôleurs de domaine

⚙️ Rôles FSMO

Les rôles FSMO sont détenus par le contrôleur :

PDC Emulator : DC9999999990

RID Master : DC9999999990

Infrastructure Master : DC9999999990

📌 Cela confirme un environnement multi-DC, utilisé pour les scénarios de confiance.

🔁 Réplication

ReplicaDirectoryServers :
{DC9999999990.DC300151833.local}

👉 Le domaine est intégré dans une réplication Active Directory fonctionnelle.

🌲 5. Vérification de la forêt (Get-ADForest)
✅ Commande utilisée :
Get-ADForest

📄 Résultat et description :

Forest Name : DC300151833.local

ForestMode : Windows2016Forest

RootDomain : DC300151833.local

Global Catalog : actif

Partitions DNS :

ForestDnsZones

DomainDnsZones

Configuration

📌 La forêt est correctement créée, DNS est intégré, et le niveau fonctionnel est conforme au projet.

✅ Résumé final

Le domaine DC300151833.local est correctement installé et fonctionnel.
La forêt Active Directory est opérationnelle, le DNS est intégré et la réplication est active.
La structure mise en place respecte les bonnes pratiques Microsoft et prépare efficacement l’environnement pour la création d’une relation de confiance entre forêts Active Directory.

🏁 Conclusion

Ce projet a permis de mettre en place une infrastructure Active Directory complète comprenant :

Un contrôleur de domaine

Un domaine fonctionnel

Une forêt Active Directory

Une base solide pour les scénarios avancés (Trust, multi-domaines)

L’environnement est prêt pour les étapes suivantes du projet
