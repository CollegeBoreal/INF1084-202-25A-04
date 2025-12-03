
############################################################
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé + groupe Students + utilisateurs
############################################################

# Charger les modules AD et SMB
Import-Module ActiveDirectory
Import-Module SmbShare

# 1️⃣ Créer le dossier partagé
$SharedFolder = "C:\SharedResources"
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2️⃣ Créer le groupe AD
$GroupName = "Students"
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access" -ErrorAction SilentlyContinue

# 3️⃣ Créer des utilisateurs AD et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true `
               -PasswordNeverExpires $true `
               -ErrorAction SilentlyContinue

    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
}

# 4️⃣ Créer le partage SMB avec autorisation FullAccess au groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName -ErrorAction SilentlyContinue

Write-Host "📁 Dossier partagé + utilisateurs + groupe créés avec succès."
