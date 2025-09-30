# Simuler une liste d'utilisateurs avec leurs informations (nom + OU)
$Users = @(
    @{ Name = "Alice Dupont"; OU = "Stagiaires" }
    @{ Name = "Jean Martin"; OU = "Professeurs" }
    @{ Name = "Claire Bernard"; OU = "Stagiaires" }
    @{ Name = "Marc Petit"; OU = "Administratif" }
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter les utilisateurs dont l'OU est "Stagiaires" dans GroupeFormation
foreach ($user in $Users) {
    if ($user.OU -eq "Stagiaires") {
        $Groups["GroupeFormation"] += $user.Name
    }
}

# Afficher les membres du groupe GroupeFormation
Write-Host "Membres du groupe GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "- $_"
}

