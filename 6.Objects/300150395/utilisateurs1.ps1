# ===================================================================
# Script : utilisateurs1.ps1
# Auteur : Ismail TRACHE (300150395)
# Objectif : Creer un dossier partage, un groupe AD et des utilisateurs
# Domaine : DC300150395-00.local
# ===================================================================

Import-Module ActiveDirectory -ErrorAction SilentlyContinue


# === Variables principales ===
$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1", "Etudiant2", "Etudiant3")

# 🔥 IMPORTANT : Remplace par l'OU EXACTE (distinguishedName)
$OUPath = "OU=Students,OU=300150395,DC=DC300150395-00,DC=local"

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

    try {
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
            New-ADUser -Name $user `
                       -SamAccountName $user `
                       -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                       -Enabled $true `
			-Path "OU=Students,OU=300150395,DC=DC300150395-00,DC=local"

            Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction Stop
            Write-Host "Utilisateur '$user' créé et ajouté au groupe '$GroupName'." -ForegroundColor Green
        }
        else {
            Write-Host "L'utilisateur '$user' existe déjà." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "❌ Erreur pour l'utilisateur '$user' : $($_.Exception.Message)" -ForegroundColor Red
    }
}

# === 4. Creation du partage SMB ===
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB 'SharedResources' créé pour le groupe '$GroupName'."
} else {
    Write-Host "Le partage SMB 'SharedResources' existe deja."
}

Write-Host "=== Etape 1 terminee : utilisateurs, groupe et partage configures. ==="
