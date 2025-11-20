# Script utilisateurs1.ps1
# Création du dossier partagé + groupe Students + utilisateurs

Import-Module ActiveDirectory

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# Nom du groupe
$GroupName = "Students"

# Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access" -ErrorAction SilentlyContinue

# Liste des utilisateurs
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true -ErrorAction SilentlyContinue
    Add-ADGroupMember -Identity $GroupName -Members $user
}

# Créer le partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
