# utilisateurs2.ps1
# Importer les utilisateurs depuis le CSV créé par creerCSV.ps1
# et afficher leur nom complet, login et OU.

# -----------------------------
# Importer les utilisateurs
# -----------------------------
$UsersObj = Import-Csv -Path "C:\Temp\UsersSimules.csv"

Write-Host "`n--- Liste complète des utilisateurs importés ---"

# -----------------------------
# Afficher les utilisateurs
# -----------------------------
$UsersObj | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

Write-Host "`n✅ Import et affichage terminés."

