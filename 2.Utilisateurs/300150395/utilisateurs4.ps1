<<<<<<< HEAD
# utilisateurs4.ps1 corrigé

# Charger les utilisateurs depuis le CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer le groupe Etudiants2025 et ajouter les utilisateurs
$Groups = @{
    "Etudiants2025" = $ImportedUsers
}

# Afficher les utilisateurs du groupe
"Utilisateurs dans Etudiants2025 :"
$Groups["Etudiants2025"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

# Exporter le groupe final en CSV
$Groups["Etudiants2025"] | Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation

=======
# utilisateurs4.ps1
# -----------------------------
# Charger les utilisateurs simulés
# -----------------------------
. ".\utilisateurs1.ps1"

# Convertir les hash tables en objets pour l'export
$UsersObj = $Users | ForEach-Object { [PSCustomObject]$_ }

# -----------------------------
# Définir le chemin CSV dans le même dossier que le script
# -----------------------------
$CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "creerCSV.csv"

# Exporter les utilisateurs vers CSV
$UsersObj | Export-Csv -Path $CsvPath -NoTypeInformation
Write-Host "CSV exporté : $CsvPath"

# -----------------------------
# Importer les utilisateurs depuis CSV
# -----------------------------
$ImportedUsers = Import-Csv -Path $CsvPath
Write-Host "`n--- Utilisateurs importés depuis CSV ---"
$ImportedUsers | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# -----------------------------
# Créer un groupe "ImportGroupe" et y ajouter tous les utilisateurs importés
# -----------------------------
$ImportGroupe = @()
$ImportedUsers | ForEach-Object { $ImportGroupe += $_ }

Write-Host "`n--- Contenu du groupe ImportGroupe ---"
$ImportGroupe | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
>>>>>>> 54cd08d30565e31023ddc67147276e79a0affa74
