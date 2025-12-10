# ================================================
# Script : trust-validation.ps1
# Objectif : Vérifier et diagnostiquer le trust
# Domaines : DC300150395-00.local <--> DC300150295-00.local
# Auteur : Ismail (300150395)
# ================================================

$RemoteDomain = "DC300150295-00.local"
$RemoteDC = "DC300150295"     # nom NetBIOS du DC
$RemoteIP = "10.7.236.229"

Write-Host "=== 1. Saisie des identifiants pour le domaine distant ===" -ForegroundColor Cyan
$cred = Get-Credential -Message "Identifiants ADMIN du domaine $RemoteDomain"

# ---------------------------------------------------------
Write-Host "`n=== 2. Tests DNS et connectivité réseau ===" -ForegroundColor Cyan
Write-Host "Résolution DNS :" -ForegroundColor Yellow
Resolve-DnsName $RemoteDomain

Write-Host "`nPing vers le DC distant ($RemoteIP):" -ForegroundColor Yellow
Test-Connection -ComputerName $RemoteIP -Count 2

Write-Host "`n=== Tests des ports Active Directory ===" -ForegroundColor Yellow
$ports = @(135, 389, 445, 88)
foreach ($p in $ports) {
    Test-NetConnection -ComputerName $RemoteIP -Port $p
}

# ---------------------------------------------------------
Write-Host "`n=== 3. Informations du domaine local ===" -ForegroundColor Cyan
Get-ADDomain

# ---------------------------------------------------------
Write-Host "`n=== 4. Informations du domaine distant ===" -ForegroundColor Cyan
Get-ADDomain -Server $RemoteDomain -Credential $cred

# ---------------------------------------------------------
Write-Host "`n=== 5. Liste des utilisateurs du domaine distant ===" -ForegroundColor Cyan
Get-ADUser -Filter * -Server $RemoteDomain -Credential $cred |
    Select SamAccountName, DistinguishedName

# ---------------------------------------------------------
Write-Host "`n=== 6. Vérification de l'état du trust ===" -ForegroundColor Cyan
Get-ADTrust -Filter *

Write-Host "`nVérification via NETDOM :" -ForegroundColor Yellow
netdom trust $RemoteDomain /Domain:DC300150395-00.local /Verify

# ---------------------------------------------------------
Write-Host "`n=== 7. Test d'accès à une ressource distante ===" -ForegroundColor Cyan
net use \\$RemoteDC\C$ /user:"$RemoteDomain\Administrator" *

Write-Host "`n=== SCRIPT TERMINÉ ===" -ForegroundColor Green
