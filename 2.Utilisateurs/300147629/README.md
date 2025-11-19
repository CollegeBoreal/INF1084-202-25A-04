#300147629
# Création d’une liste d’utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Affichage des utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Création de groupes simulés
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajout d’un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]


# Utilisateurs dont le nom commence par "B"
$Users | Where-Object {$_.Nom -like "B*"}

# Utilisateurs dans l’OU "Stagiaires"
$Users | Where-Object {$_.OU -eq "Stagiaires"}

# Utilisateurs dont le prénom contient "a" (maj/min)
$Users | Where-Object {$_.Prenom -match "[aA]"}

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer les utilisateurs depuis un fichier CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers

