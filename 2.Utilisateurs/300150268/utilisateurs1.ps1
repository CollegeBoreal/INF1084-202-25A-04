# 300150268
# Mohand Said KEMICHE
# Script : utilisateurs1.ps1
# Objectif : Créer une liste d’utilisateurs simulés et l’afficher

# Création d'une liste d'utilisateurs
$utilisateurs = @(
    @{Nom="KEMICHE"; Prenom="Mohand"; OU="Stagiaires"},
    @{Nom="BELBESSAI"; Prenom="Boualem"; OU="Professeurs"},
    @{Nom="AMRANI"; Prenom="Sofia"; OU="Stagiaires"}
)

# Ajout de 2 nouveaux utilisateurs
$utilisateurs += @{Nom="NADIR"; Prenom="Ali"; OU="Stagiaires"}
$utilisateurs += @{Nom="BOUZID"; Prenom="Karim"; OU="Employés"}

# Afficher tous les utilisateurs
Write-Host "`nListe complète des utilisateurs :"
$utilisateurs | ForEach-Object { "$($_.Prenom) $($_.Nom) - OU : $($_.OU)" }
