# ============================================================
# Script : trust-basic-check.ps1
# Objectif : Vérifier la connectivité et naviguer dans AD2
# Domaine local  : DC300150395-00.local
# Domaine distant : DC300150295-00.local
# Auteur : Ismail (300150395)
#
# NOTE :
# Le trust bidirectionnel a déjà été créé avec succès via :
# netdom trust DC300150395-00.local /Domain:DC300150295.local `
#     /UserD:administrator /PasswordD:* /Add /Realm /TwoWay
#
# ============================================================

param(
    [string]$RemoteDomainFqdn = "DC300150295-00.local",
    [string]$RemoteDC = "DC300150295"  # Nom NetBIOS réel du DC
)

Write-Host "=== 1) Vérification de la connectivité (Ping) ===" -ForegroundColor Cyan
Test-Connection -ComputerName $RemoteDomainFqdn -Count 2

Write-Host "`n=== 2) Informations du domaine AD2 ===" -ForegroundColor Cyan
$credAD2 = Get-Credential -Message "Entrez les identifiants Admin du domaine $RemoteDomainFqdn"

# Récupération des infos AD
Get-ADDomain -Server $RemoteDomainFqdn -Credential $credAD2

Write-Host "`n=== 3) Création d’un PSDrive pour AD2 ===" -ForegroundColor Cyan
New-PSDrive `
    -Name AD2 `
    -PSProvider ActiveDirectory `
    -Root "DC=DC300150295-00,DC=local" `
    -Server $RemoteDC `
    -Credential $credAD2 `
    -ErrorAction Stop

Write-Host "`nPSDrive AD2 créé avec succès." -ForegroundColor Green

# Navigation vers AD2
Set-Location AD2:\

Write-Host "`n=== 4) Contenu de la racine AD2 ===" -ForegroundColor Cyan
Get-ChildItem

# Retour au disque local
Set-Location C:\

Write-Host "`n=== Fin du script ===" -ForegroundColor Green
