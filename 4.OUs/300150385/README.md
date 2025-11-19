Nom du domaine : DC300150385-00.local
Étudiant : Belkacem Medjkoune (300150385)
Cours : INF1084 – Administration Windows Server
Professeur : Brice Robert

🎯 Objectif du TP

L’objectif de ce travail est de mettre en pratique la gestion des utilisateurs dans un domaine Active Directory à l’aide de PowerShell.
Il s’agit de manipuler les comptes utilisateurs de manière automatisée, en appliquant les principales commandes d’administration d’un environnement Windows Server.

🧩 Étapes réalisées
1️⃣ Préparation de l’environnement

Importation du module Active Directory avec la commande :

Import-Module ActiveDirectory


Vérification du domaine et du contrôleur :

Get-ADDomain
Get-ADDomainController -Filter *


Ces commandes permettent de confirmer que le domaine DC300150385-00.local est bien opérationnel et accessible.

2️⃣ Création d’un nouvel utilisateur

Un utilisateur nommé Alice Dupont a été créé directement depuis PowerShell avec un mot de passe sécurisé.
Exemple :

New-ADUser -Name "Alice Dupont" `
-GivenName "Alice" -Surname "Dupont" `
-SamAccountName "alice.dupont" `
-UserPrincipalName "alice.dupont@$domainName" `
-AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
-Enabled $true `
-Path "CN=Users,DC=DC300150385-00,DC=local" -Credential $cred

3️⃣ Modification et gestion du compte

Des opérations d’administration ont ensuite été effectuées :

Set-ADUser -Identity "alice.dupont" -EmailAddress "alice.dupont@exemple.com"
Disable-ADAccount -Identity "alice.dupont"
Enable-ADAccount -Identity "alice.dupont"


Ces commandes permettent de modifier les informations du compte et de gérer son état (actif ou désactivé).

4️⃣ Création d’une Unité d’Organisation (OU)

Une OU nommée Students a été créée pour regrouper les utilisateurs étudiants :

New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300150385-00,DC=local"


Ensuite, l’utilisateur Alice Dupont a été déplacé dans cette nouvelle OU :

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=DC300150385-00,DC=local" `
-TargetPath "OU=Students,DC=DC300150385-00,DC=local"

5️⃣ Exportation des utilisateurs dans un fichier CSV

Un export complet de tous les utilisateurs du domaine (hors comptes système) a été généré :

Get-ADUser -Filter * -Properties Name, SamAccountName, EmailAddress, Enabled |
Select-Object Name, SamAccountName, EmailAddress, Enabled |
Export-Csv -Path "TP_AD_Users.csv" -NoTypeInformation -Encoding UTF8


Ce fichier permet de vérifier la liste des utilisateurs actifs et leurs informations principales.

🧾 Résultats obtenus

✅ L’utilisateur Alice Dupont a été créé avec succès.

✅ L’OU Students a été ajoutée et l’utilisateur a été déplacé à l’intérieur.

✅ Le fichier TP_AD_Users.csv a été généré contenant tous les comptes du domaine.

✅ Toutes les actions ont été réalisées en utilisant uniquement PowerShell.

📚 Conclusion

Ce TP m’a permis de mieux comprendre comment gérer un domaine Active Directory via PowerShell.
J’ai pu :

Créer et modifier des utilisateurs,

Gérer leurs droits et leur statut,

Organiser les comptes dans des unités d’organisation,

Exporter les données pour un suivi administratif.

Ces compétences sont essentielles pour un administrateur système travaillant dans un environnement Windows Server, car elles permettent d’automatiser les tâches répétitives et d’améliorer la productivité.

📸 Tâche : Captures d’écran à insérer

🔹 Capture 1 : Vérification du domaine (Get-ADDomain)
🔹 Capture 2 : Création de l’utilisateur (New-ADUser)
🔹 Capture 3 : OU Students créée et déplacement effectué
🔹 Capture 4 : Fichier CSV généré (TP_AD_Users.csv)
🔹 Capture 5 : Résultat final dans PowerShell