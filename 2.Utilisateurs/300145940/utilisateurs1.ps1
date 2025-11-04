# THIS IS ME CREATING USER 1

$Users = @(
     @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
     @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
     @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
     @{Nom="Kadiatou"; Prenom="Diallo"; Login="Kdiallo"; OU="Stagiaires"},
     @{Nom="Sow"; Prenom="Lil"; Login="lsow"; OU="Stagiaires"}
)

#JE VEUT AFICHER LES USERS
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
