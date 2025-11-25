# ==========================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé,
#            un groupe, des utilisateurs,
#            et un partage SMB.
# ==========================================

# Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# 1️⃣ Créer le dossier
New-Item -Path $SharedFolder -ItemType Directory -Force

# 2️⃣ Nom du groupe AD
$GroupName = "Students"

# 3️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 4️⃣ Créer les utilisateurs et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 5️⃣ Créer le partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ==========================================
# Fin
# ==========================================

