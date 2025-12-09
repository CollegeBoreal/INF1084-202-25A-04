# utilisateurs1.ps1

# Script pour créer le groupe Students, ajouter des utilisateurs et créer un partage SMB

# ID Boreal : 300150295

# Importer le module Active Directory (si nécessaire)

Import-Module ActiveDirectory

# Créer le groupe AD "Students"

$GroupName = "Students"
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
}

# Créer des utilisateurs AD et les ajouter au groupe

$Users = @("Etudiant1","Etudiant2")
foreach ($user in $Users) {
if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
New-ADUser -Name $user `                   -SamAccountName $user`
-AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
-Enabled $true
}
Add-ADGroupMember -Identity $GroupName -Members $user
}

# Créer un dossier partagé

$SharedFolder = "C:\SharedResources"
if (-not (Test-Path $SharedFolder)) {
New-Item -Path $SharedFolder -ItemType Directory -Force
}

# Créer le partage SMB pour le groupe Students

if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
}

Write-Host "Groupe, utilisateurs et partage SMB créés avec succès !"
