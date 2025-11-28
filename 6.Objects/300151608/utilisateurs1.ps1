# utilisateurs1.ps1
# TP 6.Objects - Partage de ressources et création des objets AD
# Étudiant : 300151608

# Charger les infos du TP 4 (adapter le chemin si besoin)
. "..\..\4.OUs\300151608\bootstrap.ps1"

# Charger les modules AD et GPO
Import-Module ActiveDirectory
Import-Module GroupPolicy

# 1. Créer le dossier partagé
$SharedFolder = "C:\SharedResources"

if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force
    Write-Host "Dossier $SharedFolder créé."
} else {
    Write-Host "Dossier $SharedFolder existe déjà."
}

# 2. Créer le groupe Students
$GroupName = "Students"

if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GroupName -GroupScope Global -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe $GroupName créé."
} else {
    Write-Host "Groupe $GroupName existe déjà."
}

# 3. Créer des utilisateurs et les ajouter au groupe
$Users = @("Etudiant1","Etudiant2")

foreach ($user in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$user'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name $user `
                   -SamAccountName $user `
                   -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) `
                   -Enabled $true
        Write-Host "Utilisateur $user créé."
    } else {
        Write-Host "Utilisateur $user existe déjà."
    }

    # Ajouter au groupe
    Add-ADGroupMember -Identity $GroupName -Members $user -ErrorAction SilentlyContinue
    Write-Host "Utilisateur $user ajouté au groupe $GroupName."
}

# 4. Créer le partage SMB
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName
    Write-Host "Partage SMB SharedResources créé pour le groupe $GroupName."
} else {
    Write-Host "Le partage SMB SharedResources existe déjà."
}
