# ===================================================================
# Script : utilisateurs1.ps1
# Auteur : Chakib Rahmani(300150399)
# Objectif : Creer un dossier partage, un groupe AD et des utilisateurs
# Domaine : DC300150399-00.local
# ===================================================================

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# === Variables principales ===
$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1", "Etudiant2", "Etudiant3")

Write-Host "=== Demarrage du script utilisateurs1.ps1 ==="

# === 1. Creation du dossier partage ===
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
    Write-Host "Dossier cree : $SharedFolder"
} else {
    Write-Host "Le dossier existe deja : $SharedFolder"
}

# === 2. Creation du groupe AD ===
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Groupe des etudiants autorises RDP et partage reseau"
    Write-Host "Groupe '$GroupName' cree avec succes."
} else {
    Write-Host "Le groupe '$GroupName' existe deja."
}

# === 3. Creation des utilisateurs et ajout au groupe ===
foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -Path "OU=Students,DC=DC300150399-00,DC=local"
        Add-ADGroupMember -Identity $GroupName -Members $user
        Write-Host "Utilisateur '$user' cree et ajoute au groupe '$GroupName'."
    } else {
        Write-Host "L'utilisateur '$user' existe deja."
    }
}

# === 4. Creation du partage SMB ===
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB 'SharedResources' cree pour le groupe '$GroupName'."
} else {
    Write-Host "Le partage SMB 'SharedResources' existe deja."
}

Write-Host "=== Etape 1 terminee : utilisateurs, groupe et partage configures. ==="