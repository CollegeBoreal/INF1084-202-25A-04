# ============================
# TP : Simulation Active Directory
# Exercice 4 : Export et import CSV
# ============================

# 1️⃣ Liste d'utilisateurs simulés (reprend les données précédentes)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},
    @{Nom="Moreau"; Prenom="Lucas"; Login="lmoreau"; OU="Professeurs"}
)

# 2️⃣ Exporter les utilisateurs vers un fichier CSV
$CsvPath = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $CsvPath -NoTypeInformation
Write-Host "`n✅ Utilisateurs exportés vers $CsvPath" -ForegroundColor Green

# 3️⃣ Importer depuis CSV
$ImportedUsers = Import-Csv -Path $CsvPath
Write-Host "`n=== Utilisateurs importés depuis CSV ===" -ForegroundColor Cyan
$ImportedUsers | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

# 4️⃣ Créer un groupe "ImportGroupe" et ajouter tous les utilisateurs importés
$Groups = @{
    "ImportGroupe" = @()
}

$Groups["ImportGroupe"] += $ImportedUsers

# 5️⃣ Vérification
Write-Host "`n=== Membres du groupe ImportGroupe ===" -ForegroundColor Yellow
$Groups["ImportGroupe"] | ForEach-Object {
    Write-Host "$($_.Prenom) $(_

