<<<<<<< HEAD

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
=======
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

>>>>>>> b866413ea727e9d3b43541a74e97a7a61eccbda9
foreach ($user in $Users) {
    New-ADUser -Name $user `
               -SamAccountName $user `
               -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
               -Enabled $true

    Add-ADGroupMember -Identity $GroupName -Members $user
}

<<<<<<< HEAD
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
=======
# 5️⃣ Créer le partage SMB
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName

# ==========================================
# Fin
# ==========================================

>>>>>>> b866413ea727e9d3b43541a74e97a7a61eccbda9
