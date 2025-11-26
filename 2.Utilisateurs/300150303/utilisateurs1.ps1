# --- utilisateurs1.ps1 ---
# Création d'une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

# Exercice 1 : Ajouter 2 nouveaux utilisateurs
$Users += @{Nom="Durand"; Prenom="Marc"; Login="mdurand"; OU="Stagiaires"}
$Users += @{Nom="Ndiaye"; Prenom="Amina"; Login="andiaye"; OU="Stagiaires"}

# Afficher les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
