TP 6.Objects – Gestion des objets Active Directory
Étudiant : Rahmani Chakib
Numéro d’étudiant : 300150399
Domaine : DC300150399-00.local

1. Objectif du TP
-----------------
L’objectif de ce travail pratique est d’automatiser avec PowerShell la création et la gestion des objets Active Directory suivants :
- Une unité d’organisation (OU) Students
- Deux comptes utilisateurs : Etudiant1 et Etudiant2
- Un groupe global de sécurité : Students
- Un dossier partagé sur le contrôleur de domaine
- Une GPO qui mappe un lecteur réseau Z: pour les étudiants à la connexion

2. Script utilisateurs1.ps1
---------------------------
Ce script s’occupe de la préparation d’Active Directory :

- Création du dossier partagé : C:\SharedResources
- Partage du dossier avec le nom : SharedResources
- Création de l’OU : Students
- Création des comptes :
    * DC300150399-00\Etudiant1 (Pass123!)
    * DC300150399-00\Etudiant2 (Pass123!)
- Création du groupe : Students
- Ajout des membres dans le groupe :
    * Etudiant1
    * Etudiant2

Commandes de vérification utilisées :
- `Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" | Select Name, DistinguishedName`
- `Get-ADGroup -Identity "Students" | Select Name, GroupScope`
- `Get-ADUser -Filter "Name -like 'Etudiant*'" | Select Name, Enabled, DistinguishedName`

3. Script utilisateurs2.ps1
---------------------------
Ce script prépare la partie GPO et le mapping du lecteur Z: :

- Récupération du DN du domaine (`Get-ADDomain`)
- Création de la GPO : MapSharedFolder-300150399
- Lien de la GPO sur l’OU Students
- Création du script batch : C:\Scripts\MapDrive-Z.bat
    * Contenu : `net use Z: \\DC300150399-00\SharedResources /persistent:no`
- Configuration de l’ordinateur pour accepter le Bureau à distance :
    * Clé de registre fDenyTSConnections = 0
    * Activation des règles du pare-feu "Remote Desktop"

Commandes de vérification :
- `Get-GPInheritance -Target "OU=Students,DC=DC300150399-00,DC=local"`
- `Get-Content "C:\Scripts\MapDrive-Z.bat"`
- `Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Select Name, Enabled, Direction, Action`

4. Tests avec le compte Etudiant1
---------------------------------
Connexion en RDP avec :
- Utilisateur : DC300150399-00\Etudiant1
- Mot de passe : Pass123!

Vérifications faites :
- `whoami` → affiche : dc300150399-00\etudiant1
- `gpresult /r` (en tant qu’Etudiant1) → montre que la GPO MapSharedFolder-300150399 est appliquée
- Vérifier que le lecteur réseau Z: est mappé vers \\DC300150399-00\SharedResources dans l’explorateur.

5. Captures d’écran (références)
--------------------------------
Les captures suivantes ont été réalisées sur le DC :

- CAPTURE 1 : OU Students, utilisateurs Etudiant1 / Etudiant2 et groupe Students dans ADUC
- CAPTURE 2 : Résultat des commandes Get-ADOrganizationalUnit / Get-ADGroup / Get-ADUser
- CAPTURE 3 : GPMC – OU Students avec la GPO MapSharedFolder-300150399 liée
- CAPTURE 4 : Propriétés de la GPO avec le script MapDrive-Z.bat dans Scripts (Logon)
- CAPTURE 5 : Session en tant qu’Etudiant1, `whoami` + `gpresult /r`

(Les fichiers d’images sont enregistrés localement pour le dépôt Brightspace.)
