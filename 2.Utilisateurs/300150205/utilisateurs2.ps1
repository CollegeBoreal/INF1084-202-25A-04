<<<<<<< HEAD:2.Utilisateurs/300098957/utilisateurs2.ps1
# Simuler une liste d'utilisateurs avec leurs informations (nom + OU)
$Users = @(
    @{ Name = "Alice Dupont"; OU = "Stagiaires" }
    @{ Name = "Jean Martin"; OU = "Professeurs" }
    @{ Name = "Claire Bernard"; OU = "Stagiaires" }
    @{ Name = "Marc Petit"; OU = "Administratif" }
)

# Créer des groupes
=======
Write-Host "--- Membres de GroupeFormation ---"

# Exécuter le script utilisateur1.ps1 pour charger les données
& ".\utilisateurs1.ps1"

# Initialiser les groupes
>>>>>>> c5f78d8119831c7a622b6367b6f0ed31790f6937:2.Utilisateurs/300150205/utilisateurs2.ps1
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

<<<<<<< HEAD:2.Utilisateurs/300098957/utilisateurs2.ps1
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

=======
# Ajouter tous les stagiaires
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les membres du groupe
Write-Host "--- Membres de GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}


>>>>>>> c5f78d8119831c7a622b6367b6f0ed31790f6937:2.Utilisateurs/300150205/utilisateurs2.ps1
