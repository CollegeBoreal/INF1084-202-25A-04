# utilisateurs4.ps1
# Exercice 4 : Importer le fichier CSV et créer un groupe ImportGroupe avec les utilisateurs
# -----------------------------
# Charger les utilisateurs simulés
# -----------------------------
. ".\utilisateurs1.ps1"

# Importer les utilisateurs depuis le fichier CSV (dans le même dossier que le script)
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"
# Convertir les hash tables en objets pour l'export
$UsersObj = $Users | ForEach-Object { [PSCustomObject]$_ }

# Créer un groupe ImportGroupe
$Groups = @{
    "ImportGroupe" = @()
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

# Ajouter tous les utilisateurs importés dans ImportGroupe
$Groups["ImportGroupe"] += $ImportedUsers
# -----------------------------
# Créer un groupe "ImportGroupe" et y ajouter tous les utilisateurs importés
# -----------------------------
$ImportGroupe = @()
$ImportedUsers | ForEach-Object { $ImportGroupe += $_ }

# Afficher les utilisateurs du groupe ImportGroupe
"Utilisateurs dans ImportGroupe :"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
Write-Host "`n--- Contenu du groupe ImportGroupe ---"
$ImportGroupe | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
