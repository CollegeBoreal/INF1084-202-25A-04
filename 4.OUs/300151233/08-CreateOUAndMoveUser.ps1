# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Création de l'OU Students ===" -ForegroundColor Cyan

# Vérifier si l'OU existe
$domainDN = (Get-ADDomain -Server $domainName).DistinguishedName

if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -Server $domainName -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "Students" -Path $domainDN -Server $domainName -Credential $cred
    Write-Host "OU 'Students' créée" -ForegroundColor Green
} else {
    Write-Host "OU 'Students' existe déjà" -ForegroundColor Yellow
}

Write-Host "`n=== Déplacement de l'utilisateur ===" -ForegroundColor Cyan

Move-ADObject -Identity "CN=Alice Dupont,CN=Users,$domainDN" `
              -TargetPath "OU=Students,$domainDN" `
              -Server $domainName `
              -Credential $cred

Write-Host "Utilisateur déplacé vers OU=Students" -ForegroundColor Green

# Vérification
Write-Host "`n=== Vérification ===" -ForegroundColor Cyan
Get-ADUser -Identity "alice.dupont" -Server $domainName | Select-Object Name, DistinguishedName