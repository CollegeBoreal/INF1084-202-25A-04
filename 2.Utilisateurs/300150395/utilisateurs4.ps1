# utilisateurs4.ps1
# Mini-projet : création du groupe Etudiants2025 à partir des utilisateurs de Promo2025

# Importer les utilisateurs
$Users = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer le groupe Etudiants2025
$Etudiants2025 = @()
$Users | Where-Object { $_.OU -eq "Promo2025" } | ForEach-Object {
    $Etudiants2025 += $_
}

Write-Host "`n--- Utilisateurs dans Etudiants2025 ---"
$Etudiants2025 | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# Exporter le groupe vers un CSV local
$CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "Etudiants2025.csv"
$Etudiants2025 | Export-Csv -Path $CsvPath -NoTypeInformation

Write-Host "`n✅ CSV exporté avec succès : $CsvPath"

