# -----------------------------
# Charger les utilisateurs simulés
# -----------------------------
. "./utilisateurs1.ps1"

# Convertir les hash tables en objets pour l'export
$UsersObj = $Users | ForEach-Object { [PSCustomObject]$_ }

# -----------------------------
# Définir le chemin CSV dans le même dossier que le script
# -----------------------------
$CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "UsersSimules.csv"

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