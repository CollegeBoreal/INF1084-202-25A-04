# Exercice 1 : ajouter 2 utilisateurs et afficher
$Users = @(
    @{Nom="Dupont";  Prenom="Alice"; Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim"; Login="kbenali";  OU="Stagiaires"}
)
# + 2 nouveaux
$Users += @(
    @{Nom="Martin"; Prenom="Jean"; Login="jmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
