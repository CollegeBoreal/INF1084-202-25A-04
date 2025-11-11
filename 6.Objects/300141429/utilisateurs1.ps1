# ===================================================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe et des utilisateurs AD
# Auteur : Arona
# ===================================================================

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Variables
$SharedFolder = "C:\SharedResources"
$GroupName = "Students"
$Users = @("Etudiant1", "Etudiant2")

# 1. Créer le dossier partagé
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier $SharedFolder créé avec succès."
} else {
    Write-Host "Le dossier $SharedFolder existe déjà."
}

# 2. Créer le groupe AD
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe $GroupName créé."
} else {
    Write-Host "Le groupe $GroupName existe déjà."
}

# 3. Créer les utilisateurs AD et les ajouter au groupe
foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'")) {
        New-ADUser -Name $user -SamAccountName $user -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
        Add-ADGroupMember -Identity $GroupName -Members $user
        Write-Host "Utilisateur $user créé et ajouté au groupe $GroupName."
    } else {
        Write-Host "L'utilisateur $user existe déjà."
    }
}

# 4. Partager le dossier avec le groupe
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB 'SharedResources' créé pour le groupe $GroupName."
} else {
    Write-Host "Le partage SMB 'SharedResources' existe déjà."
}

Write-Host "Etape 1 terminée : Groupe, utilisateurs et partage créés."

