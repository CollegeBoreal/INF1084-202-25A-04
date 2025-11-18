# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Désactivation de l'utilisateur ===" -ForegroundColor Yellow
Disable-ADAccount -Identity "alice.dupont" -Server $domainName -Credential $cred
Write-Host "Utilisateur désactivé" -ForegroundColor Yellow

Start-Sleep -Seconds 2

Write-Host "`n=== Réactivation de l'utilisateur ===" -ForegroundColor Green
Enable-ADAccount -Identity "alice.dupont" -Server $domainName -Credential $cred
Write-Host "Utilisateur réactivé" -ForegroundColor Green