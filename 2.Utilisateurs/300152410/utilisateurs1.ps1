# utilisateurs1.ps1
# Exercice 1 : Création d'utilisateurs simulés avec ajout de 2 nouveaux

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Boudeuf"; Prenom="Imad"; Login="iboudeuf"; OU="Stagiaires"},
    @{Nom="Durand"; Prenom="Emma"; Login="edurand"; OU="Stagiaires"}
)

# Affichage de tous les utilisateurs
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
