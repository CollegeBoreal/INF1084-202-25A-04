. "$PSScriptRoot\utilisateur1.ps1"
# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter les stagiaires dans GroupeFormation
$Groups["GroupeFormation"] = $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Vérifier
Write-Output "=== Membres du GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object { "$($.Prenom) $($.Nom)" }
