# trusts2.ps1
# Vérification des trusts existants côté DC300150417-00.local

Import-Module ActiveDirectory

Write-Host "Vérification des trusts existants (domaine local)..." -ForegroundColor Cyan
nltest /trusted_domains

Write-Host "Fin de la vérification." -ForegroundColor Green