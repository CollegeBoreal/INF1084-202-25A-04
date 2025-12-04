# utilisateurs3.ps1
# Requêtes et filtres

# Liste des utilisateurs simulés
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";   Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";   Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";   Login="kbenali";  OU="Stagiaires"},
    @{Nom="amine"; Prenom="kahil";  Login="abouraoui"; OU="Stagiaires"},
    @{Nom="kahil";   Prenom="hacene"; Login="njunior";   OU="Stagiaires"}
)

# Exercice 3 : Lister tous les utilisateurs dont le prénom contient "a"
$Users | Where-Object { $_.Prenom -match "a" } | 
ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login)"
}