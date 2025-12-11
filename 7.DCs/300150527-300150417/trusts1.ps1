# trusts1.ps1
# Création d'une relation d'approbation (Trust) de type REALM
# Domaine local : DC300150417-00.local
# Domaine distant : DC300150527-00.local

Import-Module ActiveDirectory

Write-Host "Création du trust REALM bidirectionnel..." -ForegroundColor Cyan

netdom trust DC300150417-00.local `
    /Domain:DC300150527-00.local `
    /UserD:Administrator `
    /PasswordD:* `
    /Add `
    /Realm `
    /TwoWay

Write-Host "Trust créé avec succès." -ForegroundColor Green

Write-Host "Vérification du trust côté local..." -ForegroundColor Cyan
nltest /trusted_domains