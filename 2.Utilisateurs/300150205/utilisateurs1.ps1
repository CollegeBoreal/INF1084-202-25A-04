# utilisateurs1.ps1
# Exercice 1 : Ajouter 2 nouveaux utilisateurs

# Liste initiale
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajout de deux nouveaux utilisateurs
$Users += @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"}
$Users += @{Nom="Nguyen"; Prenom="Sophie"; Login="snguyen"; OU="Stagiaires"}

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
