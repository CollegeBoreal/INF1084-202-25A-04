# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajouter 2 nouveaux utilisateurs
$Users += @{Nom="boubou"; Prenom="zaza"; Login="mama"; OU="Stagiaires"}
$Users += @{Nom="gringo"; Prenom="kiki"; Login="kaka"; OU="Stagiaires"}

# Afficher tous les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }