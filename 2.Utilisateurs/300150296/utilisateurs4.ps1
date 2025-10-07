# Script utilisateurs4.ps1
# Exporter et importer les utilisateurs, puis créer un groupe

# Recréer la liste des utilisateurs
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)

# Exporter les utilisateurs simulés vers CSV
$CsvPath = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $CsvPath -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path $CsvPath

# Créer un nouveau groupe et ajouter tous les utilisateurs importés
$Groups = @{
    "ImportGroupe" = @()
}
$ImportedUsers | ForEach-Object { $Groups["ImportGroupe"] += $_ }

# Vérifier le contenu du groupe
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

