# utilisateurs1.ps1
# Charger les utilisateurs simulés depuis le CSV

$Users = Import-Csv -Path "C:\Temp\UsersSimules.csv"

Write-Host "`n--- Liste des utilisateurs simulés ---"
$Users | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

