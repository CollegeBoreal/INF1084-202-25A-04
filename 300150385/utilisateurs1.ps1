# --- utilisateurs1.ps1 ---
# 1) Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"}
)

# Exercice 1 : Ajouter 2 nouveaux utilisateurs
$Users += @(
    @{Nom="Martin";  Prenom="Nora";   Login="nmartin";  OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Amine";  Login="abernard"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object {
    "{0} {1} - Login: {2} - OU: {3}" -f $_.Prenom, $_.Nom, $_.Login, $_.OU
}
