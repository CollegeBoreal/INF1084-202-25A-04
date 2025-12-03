# ==================================================================
# Script : utilisateurs1.ps1
# Auteur : Fetis Nadir
# Identifiant : 300150485
# Objectif : Créer une liste d'utilisateurs simulés (exercice 1)
# ==================================================================

# Création d'une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Jean"; Login="jmartin"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Lina"; Login="lnguyen"; OU="Stagiaires"}
)

# Affichage des utilisateurs simulés
Write-Host "✅ Liste des utilisateurs simulés :"
$Users | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
