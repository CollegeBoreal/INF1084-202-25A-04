# ===================================================================
# Script : utilisateurs1.ps1
# Objectif : Créer un dossier partagé, un groupe et des utilisateurs AD
# Auteur : Imad Boudeuf (300152410)
# ===================================================================

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Variables
$SharedFolder = "C:\SharedResources"
$GroupName    = "Students"
$Users        = @("Etudiant1", "Etudiant2")

# 1️ Créer l'OU si elle n'existe pas
$OU_DN = "OU=Students,DC=DC300152410-00,DC=local"
if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=Students)" -SearchBase "DC=DC300152410-00,DC=local" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path "DC=DC300152410-00,DC=local"
    Write-Host "OU 'Students' créée."
}

# 2️ Créer le dossier partagé
if (-not (Test-Path $SharedFolder)) {
    New-Item -Path $SharedFolder -ItemType Directory -Force | Out-Null
    Write-Host "Dossier $SharedFolder créé."
} else {
    Write-Host "Le dossier $SharedFolder existe déjà."
}

# 3️ Créer le groupe AD
if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'")) {
    New-ADGroup -Name $GroupName -GroupScope Global -Path $OU_DN -Description "Accès RDP et dossier partagé"
    Write-Host "Groupe $GroupName créé."
} else {
    Write-Host "Le groupe $GroupName existe déjà."
}

# 4️ Créer les utilisateurs et les ajouter au groupe
foreach ($u in $Users) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$u'")) {
        New-ADUser -Name $u -SamAccountName $u -Path $OU_DN `
          -AccountPassword (ConvertTo-SecureString "Pass123!" -AsPlainText -Force) -Enabled $true
        Add-ADGroupMember -Identity $GroupName -Members $u
        Write-Host "$u créé et ajouté à $GroupName."
    } else {
        Write-Host "$u existe déjà."
    }
}

# 5️ Créer le partage SMB
if (-not (Get-SmbShare -Name "SharedResources" -ErrorAction SilentlyContinue)) {
    New-SmbShare -Name "SharedResources" -Path $SharedFolder -FullAccess $GroupName | Out-Null
    Write-Host "Partage SMB 'SharedResources' créé."
} else {
    Write-Host "Le partage SMB 'SharedResources' existe déjà."
}


