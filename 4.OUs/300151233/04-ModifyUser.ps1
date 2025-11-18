# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Modification d'un utilisateur ===" -ForegroundColor Cyan

Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -GivenName "Alice-Marie" `
           -Server $domainName `
           -Credential $cred

Write-Host "Utilisateur 'alice.dupont' modifié avec succès!" -ForegroundColor Green
