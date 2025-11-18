
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 11️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ================================
# ================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 1️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ================================
# ================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 1️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ================================
# ================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 1️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ================================
# ================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 1️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ================================
# ================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe Students,
#            des utilisateurs AD et un partage SMB.
# ================================

# 1️⃣ Chemin du dossier
$SharedFolder = "C:\SharedResources"

# 2️⃣ Créer le dossier (si n'existe pas)
New-Item -Path $SharedFolder -ItemType Directory -Force

# 3️⃣ Nom du groupe AD
$GroupName = "Students"

# 4️⃣ Créer le groupe AD
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"

# 5️⃣ Liste des utilisateurs à créer
$Users = @("Etudiant1","Etudiant2")

# 6️⃣ Créer les utilisateurs et les ajouter au groupe
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

# 7️⃣ Créer le partage SMB pour le groupe Students
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ================================
# Fin du script
# ============
