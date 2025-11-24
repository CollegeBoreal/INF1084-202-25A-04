# 300141570

# Exemple de groupes
$Groupes = @("GroupeFormation", "GroupeRH")

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
