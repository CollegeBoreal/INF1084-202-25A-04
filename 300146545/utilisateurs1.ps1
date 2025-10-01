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
