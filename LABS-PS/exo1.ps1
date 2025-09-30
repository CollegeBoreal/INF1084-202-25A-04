# exo1.ps1 - Création d'objets utilisateurs simulés

# 1) Liste initiale
$users = @(
    @{Nom="Dupont";  Prenom="Alice"; Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim"; Login="kbenali";  OU="Stagiaires"}
)

# 2) EXERCICE : ajouter 2 nouveaux utilisateurs
$users += @(
    @{Nom="Bensaid"; Prenom="Amine"; Login="abensaid"; OU="Stagiaires"},
    @{Nom="Haddad";  Prenom="Nora";  Login="nhaddad";  OU="Stagiaires"}
)

# 3) Affichage (comme dans l’énoncé)
$users | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
