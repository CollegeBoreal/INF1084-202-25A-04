
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}

$Users += @{
    Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"
}
$Users += @{
    Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"
}


$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

