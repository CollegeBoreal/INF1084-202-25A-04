# Auteur : Haroune Berkani (300141570)

# Step 1
$Groupes = @("GroupeFormation", "GroupeRH")

$utilisateurs = @(
    @{Nom="MAHREZ";     Prenom="Riyad";     OU="Stagiaires"},
    @{Nom="BENNACER";   Prenom="Ismael";    OU="Professeurs"},
    @{Nom="SLIMANI";    Prenom="Islam";     OU="Stagiaires"},
    @{Nom="FEGHOULI";   Prenom="Sofiane";   OU="Stagiaires"},
    @{Nom="MANDI";      Prenom="Aissa";     OU="Employés"}
)

# Step 2
$stagiaires = $utilisateurs | Where-Object { $_.OU -eq "Stagiaires" }

# Step 3
Write-Host "`nAjout des stagiaires dans le groupe GroupeFormation :"
foreach ($user in $stagiaires) {
    Write-Host " - $($user.Prenom) $($user.Nom) ajouté à GroupeFormation"
}
