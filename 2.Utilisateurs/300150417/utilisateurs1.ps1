      # utilisateurs1.ps1
# Exercice 1 : Ajouter 2 nouveaux utilisateurs

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

$Users += @{Nom="Martin"; Prenom="Julie"; Login="jmartin"; OU="Stagiaires"}
$Users += @{Nom="Nguyen"; Prenom="David"; Login="dnguyen"; OU="Stagiaires"}

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

