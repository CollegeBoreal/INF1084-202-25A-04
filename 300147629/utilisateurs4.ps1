# utilisateurs4.ps1
# Exercice 4 : Export et Import CSV + groupe

# Liste des utilisateurs
$Users = @(
    @{Nom="Balde"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lion"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

# Exporter vers CSV dans le dossier courant
$Users | Export-Csv -Path ".\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"

# Créer un groupe ImportGroupe et y ajouter tous les importés
$Groups = @{ "ImportGroupe" = @() }
$Groups["ImportGroupe"] += $ImportedUsers

# Vérification
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom)" }
