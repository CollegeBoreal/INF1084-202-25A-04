
# =========================================================
# Script : utilisateurs1.ps1
# Description : Création et affichage d'objets utilisateurs simulés
# =========================================================

# 1. Créer une liste d'utilisateurs simulés
$users = @(
    @{Nom="Dupont";    Prenom="Alice";     Login="adupont";   OU="Stagiaires"},
    @{Nom="Lemoine";   Prenom="Sarah";     Login="slemoine";  OU="Stagiaires"},
    @{Nom="Benali";    Prenom="Karim";     Login="kbenali";   OU="Stagiaires"},
    @{Nom="Saoudi";    Prenom="Allaoua";   Login="asaoudi";   OU="Stagiaires"},
    @{Nom="Boukaouma";Prenom="Mahmoud";   Login="mboukaouma";OU="Stagiaires"}
)

# 2. Afficher les utilisateurs
$users | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}


