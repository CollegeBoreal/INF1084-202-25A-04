# utilisateurs1.ps1
<<<<<<< HEAD
# Création liste d'utilisateurs + ajout de 2 nouveaux

$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"}
)

# Exercice 1 : +2
$Users += @(
    @{Nom="Boucher"; Prenom="Amine";   Login="aboucher"; OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nadia";   Login="nmartin";  OU="Stagiaires"}
)

# Affichage lisible
=======
$Users = @(
  @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
  @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
  @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"}
)
$Users += @(
  @{Nom="Boucher"; Prenom="Amine";  Login="aboucher"; OU="Stagiaires"},
  @{Nom="Martin";  Prenom="Nadia";  Login="nmartin";  OU="Stagiaires"}
)
>>>>>>> e5ddeffb7ce65e68b9f047c7ebea6e9eb7f83454
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }
