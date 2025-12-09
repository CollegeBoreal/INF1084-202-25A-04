# Auteur : 300150284
# TP Objets AD – Script 1
# Création du dossier partagé + groupe Students + utilisateurs

Import-Module ActiveDirectory

# 1. Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2. Créer le groupe Students
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Étudiants pour partage et RDP"

# 3. Créer utilisateurs
$Users = @("Etudiant1","Etudiant2")
foreach ($u in $Users) {
    New-ADUser -Name $u -SamAccountName $u -Enabled $true `
        -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force)
    Add-ADGroupMember -Identity $GroupName -Members $u
}

# 4. Créer le partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
