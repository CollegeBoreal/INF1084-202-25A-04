# Auteur : Kemiche Mohand Said
# TP Active Directory - Exercice 1

# Création de la liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Thierry"; Login="tnguyen"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Laura"; Login="lmartin"; OU="Stagiaires"}
)

# Afficher les utilisateurs
$Users | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
