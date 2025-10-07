<<<<<<< HEAD:2.Utilisateurs/300098957/utilisateurs4.ps1
# Définir des utilisateurs comme objets
$Users = @(
    [PSCustomObject]@{ Nom="Dupont"; Prenom="Alice"; OU="Stagiaires" }
    [PSCustomObject]@{ Nom="Diallo"; Prenom="Ibrahima"; OU="Professeurs" }
    [PSCustomObject]@{ Nom="Bah"; Prenom="Thierno"; OU="Stagiaires" }
)

# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

# Exporter les utilisateurs
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8

# Importer les utilisateurs
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Afficher les utilisateurs importés
Write-Host "Utilisateurs importés depuis le CSV :" -ForegroundColor Cyan
$ImportedUsers | Format-Table -AutoSize
=======
# -----------------------------
# Charger les utilisateurs simulés
# -----------------------------
. ".\utilisateurs1.ps1"

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

>>>>>>> c5f78d8119831c7a622b6367b6f0ed31790f6937:2.Utilisateurs/300150205/utilisateurs4.ps1
