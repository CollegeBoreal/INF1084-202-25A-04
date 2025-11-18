# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Création d'un nouvel utilisateur ===" -ForegroundColor Cyan

New-ADUser -Name "Alice Dupont" `
           -GivenName "Alice" `
           -Surname "Dupont" `
           -SamAccountName "alice.dupont" `
           -UserPrincipalName "alice.dupont@$domainName" `
           -AccountPassword (ConvertTo-SecureString "MotDePasse123!" -AsPlainText -Force) `
           -Enabled $true `
           -Path "CN=Users,$((Get-ADDomain -Server $domainName).DistinguishedName)" `
           -Server $domainName `
           -Credential $cred

Write-Host "Utilisateur 'Alice Dupont' créé avec succès!" -ForegroundColor Green