# utilisateurs1.ps1
# Matricule: 300150284
$Matricule = "300150284"
$ExportDir = "C:\TP_AD_$Matricule"
if (-not (Test-Path $ExportDir)) { New-Item -ItemType Directory -Path $ExportDir | Out-Null }

# --- Liste initiale (3 utilisateurs)
$Users = @(
    [PSCustomObject]@{Nom="Dupont";  Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Benali";  Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Exercice 1 : ajouter 2 nouveaux utilisateurs
$Users += [PSCustomObject]@{Nom="Martin";  Prenom="Luc";   Login="lmartin";  OU="Stagiaires"}
$Users += [PSCustomObject]@{Nom="Nguyen";  Prenom="Amina"; Login="anguyen";  OU="Stagiaires"}

# Afficher les utilisateurs
Write-Host "== Liste des utilisateurs ($($Users.Count)) =="
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Exporter pour réutilisation
$csvPath = Join-Path $ExportDir "UsersSimules_$Matricule.csv"
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
Write-Host "Export CSV -> $csvPath"

