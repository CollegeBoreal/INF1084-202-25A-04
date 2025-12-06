# ---------------------------------------------------------
# Script : utilisateurs2.ps1
# Auteur : Mohammed Aiche
# ID     : 300151608
# Objectif : Désactiver l'utilisateur test01
# ---------------------------------------------------------

Import-Module ActiveDirectory

$user = Get-ADUser -Filter "SamAccountName -eq 'test01'" -ErrorAction SilentlyContinue

if ($user) {
    Disable-ADAccount -Identity "test01"
    Write-Host "Utilisateur test01 désactivé." -ForegroundColor Green
}
else {
    Write-Host "Utilisateur test01 introuvable." -ForegroundColor Red
}
