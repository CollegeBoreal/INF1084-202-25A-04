. "$PSScriptRoot\utilisateurs1.ps1" > $null

# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter les stagiaires dans GroupeFormation
$Groups["GroupeFormation"] += $Users[0]
$Groups["GroupeFormation"] += $Users[1]
$Groups["GroupeFormation"] += $Users[2]
$Groups["GroupeFormation"] += $Users[3]
$Groups["GroupeFormation"] += $Users[4]

# Afficher le contenu des groupes
foreach ($group in $Groups.Keys) {
    Write-Host "$group"
    $Groups[$group] | ForEach-Object { 
        Write-Host "$($_.Prenom) $($_.Nom) ($($_.Login))"
    }
    Write-Host ""
}