# Charger les informations du bootstrap
. .\bootstrap.ps1

# Importer le module AD
Import-Module ActiveDirectory

Write-Host "=== Modification des utilisateurs ===" -ForegroundColor Cyan

# Modifier Alice Dupont
Write-Host "`n1. Modification de alice.dupont" -ForegroundColor Yellow
Set-ADUser -Identity "alice.dupont" `
           -EmailAddress "alice.dupont@exemple.com" `
           -Description "Stagiaire - Département IT" `
           -Server $domainName `
           -Credential $cred
Write-Host "✓ Email et description ajoutés" -ForegroundColor Green

# Désactiver Bob Martin
Write-Host "`n2. Désactivation de bob.martin" -ForegroundColor Yellow
Disable-ADAccount -Identity "bob.martin" -Server $domainName -Credential $cred
Write-Host "✓ Compte désactivé" -ForegroundColor Green

Start-Sleep -Seconds 2

# Réactiver Bob Martin
Write-Host "`n3. Réactivation de bob.martin" -ForegroundColor Yellow
Enable-ADAccount -Identity "bob.martin" -Server $domainName -Credential $cred
Write-Host "✓ Compte réactivé" -ForegroundColor Green

# Rechercher des utilisateurs avec filtre
Write-Host "`n4. Recherche d'utilisateurs dont le prénom commence par 'A'" -ForegroundColor Yellow
Get-ADUser -Filter "GivenName -like 'A*'" -Server $domainName -Properties Name, SamAccountName, EmailAddress |
Select-Object Name, SamAccountName, EmailAddress |
Format-Table -AutoSize

# Afficher l'état final
Write-Host "`n=== État final des utilisateurs ===" -ForegroundColor Cyan
Get-ADUser -Filter "SamAccountName -like '*.*'" -Server $domainName -Properties Name, Enabled, EmailAddress |
Select-Object Name, SamAccountName, Enabled, EmailAddress |
Format-Table -AutoSize