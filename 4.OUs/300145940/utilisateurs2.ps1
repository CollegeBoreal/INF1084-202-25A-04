# Script revu par : Tasnim (300145940)
# Objectif : Gestion simple de groupes et filtrage d’utilisateurs

# Étape 1 – Déclaration des groupes existants et des utilisateurs simulés
$Groupes = @("GroupeFormation", "GroupeRH")

$utilisateurs = @(
    @{Nom="LEFEBVRE"; Prenom="Alex";    OU="Stagiaires"},
    @{Nom="MORIN";    Prenom="Leila";   OU="Professeurs"},
    @{Nom="BENALI";   Prenom="Yasmine"; OU="Stagiaires"},
    @{Nom="DURAND";   Prenom="Hugo";    OU="Stagiaires"},
    @{Nom="KHELIFA";  Prenom="Maya";    OU="Employés"}
)

# Étape 2 – Extraction des utilisateurs appartenant à l’OU “Stagiaires”
$stagiaires = $utilisateurs | Where-Object { $_.OU -eq "Stagiaires" }

# Étape 3 – Affichage des stagiaires à insérer dans le groupe GroupeFormation
Write-Host "`nAjout des stagiaires dans le groupe GroupeFormation :"
foreach ($user in $stagiaires) {
    Write-Host " - $($user.Prenom) $($user.Nom) ajouté à GroupeFormation"
}

