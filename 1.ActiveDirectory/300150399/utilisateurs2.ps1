# utilisateurs2.ps1
# Reprise des utilisateurs
if (-not $Users) {
    Write-Host "⚠️ Lance d’abord utilisateurs1.ps1"
    exit
}

# Créer groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les stagiaires
$Groups["GroupeFormation"] = $Users | Where-Object { $_.OU -eq "Stagiaires" }
"Nombre dans GroupeFormation : $($Groups["GroupeFormation"].Count)"
