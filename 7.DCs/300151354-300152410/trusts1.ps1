# trust1.ps1
# Vérification DNS et connectivité avant la création du trust

Import-Module ActiveDirectory

Write-Host "=== Vérification de la résolution DNS du domaine distant ===" -ForegroundColor Cyan
nslookup DC300151354-00.local

Write-Host "=== Vérification de la connectivité (Ping) ===" -ForegroundColor Cyan
Test-Connection DC300151354-00.local -Count 3

Write-Host "=== Vérification des informations du contrôleur distant ===" -ForegroundColor Cyan
nltest /dsgetdc:DC300151354-00.local
