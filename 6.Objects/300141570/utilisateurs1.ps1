# utilisateurs1.ps1
# TP 6.Objects - Création des OU, groupes et utilisateurs
# Étudiant : 300141570

# Charger le bootstrap
$bootstrapPath = Join-Path $PSScriptRoot '..\..\4.OUs\bootstrap.ps1'
if (-not (Test-Path $bootstrapPath)) {
    Write-Error "Impossible de trouver le fichier bootstrap.ps1 à l'emplacement : $bootstrapPath"
    exit 1
}
. $bootstrapPath

Import-Module ActiveDirectory -ErrorAction Stop

# Récupérer le DN du domaine (ex : DC=DC300141570-0,DC=local)
$domain = Get-ADDomain -Server $domainName
$domainDN = $domain.DistinguishedName

#Créer l'OU Students si elle n'existe pas
$ouName = "Students"
$ouDN   = "OU=$ouName,$domainDN"

if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$ouName)" -SearchBase $domainDN -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $ouName -Path $domainDN -ProtectedFromAccidentalDeletion $false
    Write-Host "OU '$ouName' créée : $ouDN" -ForegroundColor Green
} else {
    Write-Host "OU '$ouName' existe déjà : $ouDN" -ForegroundColor Yellow
}

#Créer le groupe Students (global, sécurité)
$groupName = "Students"

if (-not (Get-ADGroup -Filter "Name -eq '$groupName'" -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $groupName `
                -GroupScope Global `
                -GroupCategory Security `
                -Path $ouDN `
                -Description "Users allowed RDP and shared folder access"
    Write-Host "Groupe '$groupName' créé dans $ouDN" -ForegroundColor Green
} else {
    Write-Host "Groupe '$groupName' existe déjà" -ForegroundColor Yellow
}

#Créer des utilisateurs dans l'OU Students
$password = ConvertTo-SecureString "Infra@2024" -AsPlainText -Force

$users = @(
    @{ Prenom = "Etudiant"; Nom = "Un";   Sam = "Etudiant1" },
    @{ Prenom = "Etudiant"; Nom = "Deux"; Sam = "Etudiant2" },
    @{ Prenom = "Etudiant"; Nom = "Trois"; Sam = "Etudiant3" }
)

foreach ($u in $users) {
    $sam  = $u.Sam
    $name = "$($u.Prenom) $($u.Nom)"

    if (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) {
        Write-Host "Utilisateur $sam existe déjà, on le saute." -ForegroundColor Yellow
        continue
    }

    New-ADUser -Name $name `
               -SamAccountName $sam `
               -GivenName $u.Prenom `
               -Surname $u.Nom `
               -AccountPassword $password `
               -Enabled $true `
               -Path $ouDN `
               -ChangePasswordAtLogon $false

    Write-Host "Utilisateur créé : $name ($sam)" -ForegroundColor Green

    # Ajouter au groupe Students
    Add-ADGroupMember -Identity $groupName -Members $sam
    Write-Host " -> Ajouté au groupe $groupName" -ForegroundColor Cyan
}

Write-Host "Création des utilisateurs et du groupe terminée." -ForegroundColor Green
