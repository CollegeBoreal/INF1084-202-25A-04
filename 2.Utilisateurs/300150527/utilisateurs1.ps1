# utilisateurs1.ps1
# Création d'objets utilisateurs simulés

# Liste des utilisateurs simulés
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";   Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";   Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";   Login="kbenali";  OU="Stagiaires"},

    # ---- Ajouts demandés ----
    @{Nom="Bouraoui"; Prenom="Akrem";  Login="abouraoui"; OU="Stagiaires"},
    @{Nom="Junior";   Prenom="Neymar"; Login="njunior";   OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object { 
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" 
}
