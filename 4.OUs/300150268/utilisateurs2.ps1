# 300150268
# Mohand Said KEMICHE
# Script : utilisateurs2.ps1
# Objectif : Créer des groupes et y ajouter des utilisateurs

# Exemple de groupes
$Groupes = @("GroupeFormation", "GroupeRH")

# Liste d’utilisateurs simulés
$utilisateurs = @(
    @{Nom="KEMICHE"; Prenom="Mohand"; OU="Stagiaires"},
    @{Nom="BELBESSAI"; Prenom="Boualem"; OU="Professeurs"},
    @{Nom="AMRANI"; Prenom="Sofia"; OU="Stagiaires"},
    @{Nom="NADIR"; Prenom="Ali"; OU="Stagiaires"},
    @{Nom="BOUZID"; Prenom="Karim"; OU="Employés"}
)

# Sélection des utilisateurs dont l’OU = "Stagiaires"
$stagiaires = $utilisateurs | Where-Object { $_.OU -eq "Stagiaires" }

Write-Host "`nAjout des stagiaires dans le groupe GroupeFormation :"
foreach ($user in $stagiaires) {
    Write-Host " - $($user.Prenom) $($user.Nom) ajouté à GroupeFormation"
}
