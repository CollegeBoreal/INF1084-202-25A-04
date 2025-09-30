# Exercice 3 : lister les prénoms contenant 'a' (insensible à la casse)
$Users = @(
    @{Nom="Dupont";  Prenom="Alice"; Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim"; Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Jean";  Login="jmartin";  OU="Stagiaires"},
    @{Nom="Nguyen";  Prenom="Lina";  Login="lnguyen";  OU="Stagiaires"}
)
"=== Prénoms contenant 'a' (i) ==="
$Users | Where-Object { $_.Prenom -imatch "a" } |
  ForEach-Object { "{0} {1} - Login: {2}" -f $_.Prenom, $_.Nom, $_.Login }
