🖥️ 300151833 – Vérification et Description du Domaine Active Directory
🔍 Commande exécutée : Get-ADDomain

Cette commande permet d’afficher toutes les informations essentielles du domaine Active Directory installé sur le contrôleur de domaine DC300151833.

🗂️ Description détaillée des informations du domaine
✔ Nom du domaine (DNSRoot)

DC300151833.local
Le domaine fonctionne avec un suffixe DNS standard .local et constitue la racine de ta forêt Active Directory.

✔ Nom NetBIOS

DC300151833AD
C’est le nom utilisé pour les opérations héritées (compatibilité Windows anciens).
Ton NetBIOS est personnalisé, ce qui est très bien 👍.

✔ Distinguished Name (DN)

DC=DC300151833,DC=local
Identifie ton domaine dans l'arborescence LDAP.

✔ Conteneurs systèmes

ComputersContainer → CN=Computers,DC=DC300151833,DC=local
Emplacement par défaut des ordinateurs ajoutés au domaine.

UsersContainer → CN=Users,DC=DC300151833,DC=local
Contient par défaut les comptes utilisateurs et groupes standards.

DomainControllersContainer →
OU=Domain Controllers,DC=DC300151833,DC=local
Emplacement où ton contrôleur de domaine est automatiquement placé.

✔ Rôles FSMO du domaine

Tous tes rôles principaux sont détenus par ton DC secondaire DC9999999990.DC300151833.local, ce qui est normal dans ton lab :

PDCEmulator → DC9999999990

RIDMaster → DC9999999990

InfrastructureMaster → DC9999999990

Cela indique que ton domaine fait partie d’un environnement multi-DC, probablement pour ton projet de relation de confiance.

✔ Mode du domaine

Windows2016Domain
Tu utilises le niveau fonctionnel Windows Server 2016, conforme au TP et aux bonnes pratiques actuelles.

✔ Réplication et serveurs supplémentaires

ReplicaDirectoryServers : {DC9999999990.DC300151833.local}
Ton domaine possède un autre DC faisant partie de la réplication AD → ce qui est normal pour le projet de trust entre forêts.

✔ Partitions AD

Ton domaine possède les 3 partitions AD standards :

ForestDnsZones

DomainDnsZones

Configuration

Cela confirme que DNS est bien intégré et que ta forêt AD est opérationnelle.

✔ Conteneurs systèmes divers

LostAndFoundContainer

ForeignSecurityPrincipalsContainer

NTDS Quotas

System

Ces conteneurs appartiennent à l’infrastructure interne AD et servent au fonctionnement du domaine.

🧾 Résumé professionnel pour ton REDAM

Ton domaine DC300151833.local est correctement installé et fonctionnel.
Les rôles FSMO sont gérés par le contrôleur DC9999999990, ce qui confirme un environnement multi-DC utilisé pour le projet de confiance entre forêts.
La structure LDAP, les partitions DNS et les conteneurs systèmes montrent une configuration conforme aux normes Active Directory Windows Server 2016.
