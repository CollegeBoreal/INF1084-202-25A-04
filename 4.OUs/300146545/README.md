🚀 TP : Gestion des utilisateurs Active Directory avec PowerShell
ETUDIANT:SAOUDI ALAOUA 
👨‍💻 Étudiant : 300146545
🌐 Domaine : DC300146545-00.local
🎯 Objectif du TP
Gérer les utilisateurs dans ton domaine DC300146545-00.local, avec les corrections pour le container CN=Users et la création de l’OU Students.

🔧 Étapes principales
Préparer l’environnement AD
Lister les utilisateurs
Créer, modifier, activer/désactiver et supprimer des utilisateurs
Déplacer les utilisateurs vers l’OU Students
Exporter les utilisateurs dans un CSV
📚 Commandes principales (PowerShell)
\ = 300146545 \ = 00 \ = "DC-.local" \ = "DC-"

Import-Module ActiveDirectory

Connexion administrateur
\ = Get-Credential

Création d'un utilisateur test
New-ADUser -Name "Alice Dupont" -GivenName "Alice" -Surname "Dupont" -SamAccountName "alice.dupont" -UserPrincipalName "alice.dupont@" -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) -Enabled \True -Path "CN=Users,DC=,DC=local" -Credential \

Création de l'OU Students
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'")) { New-ADOrganizationalUnit -Name "Students" -Path "DC=,DC=local" }

Déplacement de l’utilisateur
Move-ADObject -Identity "CN=Alice Dupont,CN=Users,DC=,DC=local" -TargetPath "OU=Students,DC=,DC=local" -Credential \

Vérifier
Get-ADUser -Identity "alice.dupont" | Select-Object Name, DistinguishedName