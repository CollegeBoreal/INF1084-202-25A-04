# Définir les utilisateurs comme objets PowerShell
$Users = @(
    [PSCustomObject]@{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},
    [PSCustomObject]@{Nom="Tremblay"; Prenom="Marc"; Login="mtremblay"; OU="Stagiaires"}
)

# Chemin CSV dans le répertoire actuel
$CsvPath = ".\UsersSimules.csv"

# Exporter les utilisateurs dans le CSV
$Users | Export-Csv -Path $CsvPath -NoTypeInformation

# Importer depuis le CSV
$ImportedUsers = Import-Csv -Path $CsvPath

# Créer le groupe "ImportGroupe"
$Groups = @{ "ImportGroupe" = @() }

# Ajouter tous les utilisateurs importés dans le groupe
$Groups["ImportGroupe"] += $ImportedUsers

# Afficher le contenu du groupe
$Groups["ImportGroupe"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

