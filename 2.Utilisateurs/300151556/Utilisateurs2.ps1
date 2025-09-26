# Définir la liste des utilisateurs
$Users = @(
    @{ Name = "Alice Dupont"; Login = "adupont"; OU = "Stagiaires" }
    @{ Name = "Sarah Lemoine"; Login = "slemoine"; OU = "Stagiaires" }
    @{ Name = "Karim Benali"; Login = "kbenali"; OU = "Stagiaires" }
    @{ Name = "Kahina Zerkani"; Login = "kzerkani"; OU = "Stagiaires" }
    @{ Name = "Lina Zergui"; Login = "lzergui"; OU = "Stagiaires" }
)

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les utilisateurs dont l’OU = "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les membres de GroupeFormation
foreach ($u in $Groups["GroupeFormation"]) {
    Write-Output "$($u.Name) - Login: $($u.Login)"
}

