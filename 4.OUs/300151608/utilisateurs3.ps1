# ---------------------------------------------------------
# Script : utilisateurs3.ps1
# Auteur : Mohammed Aiche
# ID     : 300151608
# Objectif : Réactiver l'utilisateur test01
# ---------------------------------------------------------

Import-Module ActiveDirectory

$user = Get-ADUser -Filter "SamAccountName -eq 'test01'" -ErrorAction SilentlyContinue

if ($user) {
    Enable-ADAccount -Identity "test01"
    Write-Host "Utilisateur test01 réactivé avec succès !" -ForegroundColor Green
}
else {
    Write-Host "Utilisateur test01 introuvable." -ForegroundColor Red
}
