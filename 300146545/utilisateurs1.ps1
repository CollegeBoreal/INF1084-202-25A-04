<<<<<<< HEAD
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Morel"; Prenom="Thomas"; Login="tmorel"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Sophie"; Login="snguyen"; OU="Stagiaires"}
)

# Vérifier affichage
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

=======
# ==========================================================
# Script : utilisateurs1.ps1
# Auteur : [Ton Nom]
# Description : Création et affichage d'objets utilisateurs simulés
# ==========================================================

# 1. Créer une liste d'utilisateurs simulés
$users = @(
    [PSCustomObject]@{ Nom = "Dupont";  Prenom = "Alice";   Login = "adupont";  OU = "stagiaires" }
    [PSCustomObject]@{ Nom = "Lemoine"; Prenom = "Karim";   Login = "klemoine"; OU = "stagiaires" }
    [PSCustomObject]@{ Nom = "Benali";  Prenom = "Sarah";   Login = "sbenali";  OU = "stagiaires" }
)

# 2. Afficher les utilisateurs simulés
$users | ForEach-Object { 
    Write-Output ("Nom: {0} | Prénom: {1} | Login: {2} | OU: {3}" -f $_.Nom, $_.Prenom, $_.Login, $_.OU)
}
>>>>>>> e7ca14532d1dfd370d8e3994b5211a6e8e0899a2
