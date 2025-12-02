Write-Host "=== Script 4 : Export CSV, import et groupe ImportGroupe ==="

# Dot-sourcing
Write-Host "Chargement des utilisateurs via Script 1..."
. .\utilisateurs1.ps1
Write-Host "Utilisateurs chargés."

# Déterminer le bon dossier temporaire (Windows/macOS/Linux)
$TempPath = [System.IO.Path]::GetTempPath()
Write-Host "Dossier temporaire détecté : $TempPath"

$CsvPath = Join-Path $TempPath "UsersSimules.csv"

# Export CSV
Write-Host "Exportation des utilisateurs vers CSV..."
$Users | Export-Csv -Path $CsvPath -NoTypeInformation
Write-Host "Fichier créé : $CsvPath"

# Import CSV
Write-Host "Importation des utilisateurs depuis le CSV..."
$ImportedUsers = Import-Csv -Path $CsvPath
Write-Host "Importation terminée. Utilisateurs trouvés : $($ImportedUsers.Count)"

# Création du groupe ImportGroupe
$ImportGroupe = @()

foreach ($u in $ImportedUsers) {
    $ImportGroupe += $u
    Write-Host "Ajout de $($u.Prenom) $($u.Nom) dans ImportGroupe."
}

Write-Host "ImportGroupe créé avec $($ImportGroupe.Count) utilisateurs."
