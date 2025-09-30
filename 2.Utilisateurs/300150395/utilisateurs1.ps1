# Script utilisateurs1.ps1
# Création des utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Ajouter 2 nouveaux utilisateurs
$Users += @{Nom="Trache"; Prenom="Ismail"; Login="Tismail"; OU="Stagiaires"}
$Users += @{Nom="Nemouss"; Prenom="Latif"; Login="Nlatif"; OU="Stagiaires"}

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }


