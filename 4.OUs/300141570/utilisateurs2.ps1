# Auteur : Haroune Berkani (300141570)

# Step 1
$Groupes = @("GroupeFormation", "GroupeRH")

$utilisateurs = @(
    @{Nom="BENALI";   Prenom="Yassine"; OU="Stagiaires"},
    @{Nom="KHALDI";   Prenom="Nadia";   OU="Professeurs"},
    @{Nom="HADDAD";   Prenom="Karim";   OU="Stagiaires"},
    @{Nom="SAIDANI";  Prenom="Amine";   OU="Stagiaires"},
    @{Nom="ROUANE";   Prenom="Sabrina"; OU="Employés"}
)

# Step 2
$stagiaires = $utilisateurs | Where-Object { $_.OU -eq "Stagiaires" }

# Step 3
Write-Host "`nAjout des stagiaires dans le groupe GroupeFormation :"
foreach ($user in $stagiaires) {
    Write-Host " - $($user.Prenom) $($user.Nom) ajouté à GroupeFormation"
}
