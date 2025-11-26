# TP 6.Objects - Script utilisateurs1.ps1
# Etudiant : Rahmani Chakib (300150399)
# Objectif : Créer dossier partagé, groupe Students, utilisateurs et partage SMB

# 1) Importer le module Active Directory
Import-Module ActiveDirectory

# 2) Chemin du dossier partagé
$SharedFolder = "C:\SharedResources"

# Créer le dossier s'il n'existe pas
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
}

# 3) Créer le groupe AD "Students" (s'il n'existe pas déjà)
$GroupName = "Students"

if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
}

# 4) Créer des utilisateurs et les ajouter au groupe
$Users = @("Etudiant1", "Etudiant2")

foreach ($user in $Users) {

    # Vérifier si l'utilisateur existe déjà
    $existingUser = Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue

    if (-not $existingUser) {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true
    }

    # Ajouter l'utilisateur au groupe Students
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
}

# 5) Créer le partage SMB pour le groupe Students
# Si un partage du même nom existe déjà, on peut le laisser ou le recréer

$ShareName = "SharedResources"

# Vérifier si le partage existe déjà
$existingShare = Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue

if (-not $existingShare) {
    New-SmbShare -Name $ShareName -Path $SharedFolder -FullAccess $GroupName
}
