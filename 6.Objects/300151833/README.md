📘 REDAM – Vérification AD, GPO, Script Logon et Accès RDP

Étudiant : 300151833 – Raouf Bouras
Serveur : DC300151833
Domaine : DC300151833.local

🎯 Objectif du REDAM

Ce document présente toutes les vérifications techniques effectuées sur le serveur Active Directory pour confirmer :

Le bon fonctionnement du partage SMB

L’existence du groupe AD Students

Les utilisateurs créés (ex. Alice Dupont)

Les membres du groupe

La GPO MapSharedFolder

Le script de connexion logon

L’état RDP du serveur

Les règles firewall RDP

Les tests de connexion avec un utilisateur du groupe Students

Toutes les vérifications ont été réalisées en PowerShell.

🟦 1️⃣ Vérifier le partage SMB
🔹 Commande PowerShell
Get-SmbShare

🔍 Description

Cette commande affiche tous les partages SMB du serveur.
Elle permet de confirmer que :

Le dossier SharedResources

Est bien partagé

Et accessible au groupe Students

🟦 2️⃣ Vérifier le groupe AD "Students"
🔹 Commande PowerShell
Get-ADGroup Students

🔍 Description

Montre les propriétés du groupe Students dans Active Directory.
Preuve que le groupe a été créé :

Nom

Description

SID

portée

Catégorie de groupe

🟦 3️⃣ Vérifier les utilisateurs créés (ex. Alice Dupont)
🔹 Commandes PowerShell
Get-ADUser alice.dupont


Si tu as créé plusieurs utilisateurs Students :

Get-ADUser student1
Get-ADUser student2

🔍 Description

Affiche les propriétés des comptes utilisateurs.
Permet de confirmer qu’ils existent dans :

👉 OU=Students,DC=DC300151833,DC=local

🟦 4️⃣ Vérifier les membres du groupe Students
🔹 Commande PowerShell
Get-ADGroupMember Students

🔍 Description

Liste les membres du groupe Students.
Preuve que les comptes (ex. alice.dupont) sont bien ajoutés.

🟦 5️⃣ Vérifier la présence et l’état des GPO
🔹 Commande PowerShell
Get-GPO -All | Format-Table DisplayName, Owner, GpoStatus

🔍 Description

Cette commande :

Liste toutes les GPO du domaine

Vérifie que MapSharedFolder existe

Confirme qu’elle est activée

🟦 6️⃣ Vérifier le lien GPO avec l’OU
🔹 Commande PowerShell
Get-GPOReport -Name "MapSharedFolder" -ReportType Html -Path C:\GPO_MapSharedFolder.html

🔍 Description

Le rapport généré permet de vérifier :

Le lien GPO → OU Students

Les paramètres configurés

L’état de la GPO

Le filtrage de sécurité

🟦 7️⃣ Vérifier le script logon
🔹 Commande PowerShell
Get-Content C:\Scripts\MapDrive-Z.bat

🔍 Description

Affiche le contenu du script d’ouverture de session.
Le script doit contenir une commande similaire à :

net use Z: \\DC300151833\SharedResources

🟦 8️⃣ Vérifier l’activation du RDP
🔹 Commande PowerShell
Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Terminal Server" | Select fDenyTSConnections

🔍 Description

Cette clé de registre indique :

0 = RDP activé

1 = RDP désactivé

Preuve que le serveur accepte les connexions RDP.

🟦 9️⃣ Vérifier les règles Firewall RDP
🔹 Commande PowerShell
Get-NetFirewallRule -DisplayGroup "Remote Desktop"

🔍 Description

Affiche les règles firewall liées au service RDP :

Port autorisé

Profil activé

Direction

État Enabled


🟦 🔟 Test de connexion utilisateur (Ex. Alice Dupont)
🔹 Test effectué

Connexion à distance avec l’utilisateur :

alice.dupont@DC300151833.local

🔍 Description

Le test confirme :

Que le compte Students peut se connecter

Que le mappage du lecteur fonctionne

Que les permissions SMB sont correctes

🟥 1️⃣1️⃣ Test avec un utilisateur NON membre du groupe Students
🔍 Description

Un utilisateur qui n’appartient pas au groupe Students :

Ne peut PAS accéder au partage SMB

Ne peut PAS exécuter la GPO MapSharedFolder

Ne peut PAS mapper le lecteur Z


🏁 Conclusion

Ce REDAM démontre que le serveur DC300151833 est entièrement fonctionnel pour :

La gestion ADDS

Les groupes

Les utilisateurs

Les partages réseau SMB

Les scripts logon

L’application des GPO

L’accès RDP

Les règles firewall associées

Toutes les vérifications techniques ont été réalisées avec PowerShell et validées lors des tests utilisateurs.
