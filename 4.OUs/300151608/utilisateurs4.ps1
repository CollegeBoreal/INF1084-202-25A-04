# ---------------------------------------------------------
# Script : utilisateurs4.ps1
# Auteur : Mohammed Aiche
# ID     : 300151608
# Objectif : Deplacer test01 vers l'OU Students
# ---------------------------------------------------------

Import-Module ActiveDirectory

# Domaine correct
$root = "DC=dc300151608,DC=local"
$ouPath = "OU=Students,$root"

Write-Host "Domaine utilise : $root"

# Verifier si l'OU Students existe
$ou = Get-ADOrganizationalUnit -Filter "Name -eq 'Students'" -ErrorAction SilentlyContinue

if (-not $ou) {
    New-ADOrganizationalUnit -Name "Students" -Path $root
    Write-Host "OU Students creee." -ForegroundColor Yellow
}

# Recuperer l'utilisateur
$user = Get-ADUser -Identity "test01" -ErrorAction SilentlyContinue

if ($user) {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $ouPath
    Write-Host "Utilisateur test01 deplace avec succes !" -ForegroundColor Green
}
else {
    Write-Host "Utilisateur test01 introuvable." -ForegroundColor Red
}
