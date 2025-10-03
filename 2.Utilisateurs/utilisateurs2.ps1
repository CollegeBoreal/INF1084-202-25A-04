<<<<<<< HEAD
# utilisateurs2.ps1
$Users = @(
    @{Nom="Durand"; Prenom="Emma"; Login="edurand"; OU="Stagiaires"},
    @{Nom="Moreau"; Prenom="Paul"; Login="pmoreau"; OU="Stagiaires"}
@{Nom="Lionel"; Prenom="Messi"; Login="LM10"; OU="Stagiaires"},
@{Nom="Cristiano"; Prenom="Ronaldo"; Login="CR7"; OU="Stagiaires"},
@{Nom="Neymar"; Prenom="junior"; Login="NJ10"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

=======
# Simuler une liste d'utilisateurs avec leurs informations (nom + OU)
$Users = @( 
   @{ Name = "messi gui"; OU = "Stagiaires" }, 
   @{ Name = "paul kile"; OU = "Professeurs" }, 
   @{ Name = "lil baby"; OU = "Stagiaires" },
   @{ Name = "Minue gnue"; OU = "Administratif" }
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
>>>>>>> 70ba2db080456304b99321e887fe230bb7f9714b
