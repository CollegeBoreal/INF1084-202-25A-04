$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

$Users += @(
    @{Nom="Martin"; Prenom="Luc"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="bouhali"; Prenom="rabia"; Login="Ravi3"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

