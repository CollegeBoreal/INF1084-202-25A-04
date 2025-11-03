# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"},     # Nouvel utilisateur 1
    @{Nom="Tremblay"; Prenom="Marc"; Login="mtremblay"; OU="Stagiaires"}  # Nouvel utilisateur 2
)

# Afficher tous les utilisateurs
$Users | ForEach-Object { 
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}

