# utilisateurs1.ps1
# Auteur   : Haroune Berkani 300141570

# 1️⃣ Création d'utilisateurs 
$Users = @(
    @{Nom="Mahrez";     Prenom="Riyad";    Login="rmahrez";    OU="Stagiaires"},
    @{Nom="Bennacer";   Prenom="Ismael";   Login="ibennacer";  OU="Stagiaires"},
    @{Nom="Slimani";    Prenom="Islam";    Login="islimani";   OU="Stagiaires"},
    @{Nom="Feghouli";   Prenom="Sofiane";  Login="sfeghouli";  OU="Stagiaires"},
    @{Nom="Mandi";      Prenom="Aissa";    Login="amandi";     OU="Stagiaires"}
)

$Users | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
