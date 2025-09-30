# Fatou1.ps1
# Création des utilisateurs simulés et export CSV

# Créer la liste des utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Thi"; Login="tnguyen"; OU="Stagiaires"},
    @{Nom="Diallo"; Prenom="Moussa"; Login="mdiallo"; OU="Stagiaires"}
)

# Chemin CSV relatif au script
$CSVPath = Join-Path $PSScriptRoot "UsersSimules.csv"

# Export des utilisateurs
$Users | Export-Csv -Path $CSVPath -NoTypeInformation

# Afficher les utilisateurs
Write-Host "[Liste des utilisateurs]"
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

