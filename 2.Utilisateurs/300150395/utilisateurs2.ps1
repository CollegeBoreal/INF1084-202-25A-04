# utilisateurs2.ps1
Write-Host "--- Membres de GroupeFormation ---"

# Exécuter le script utilisateur1.ps1 pour charger les données
& ".\utilisateurs1.ps1"

# Initialiser les groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les stagiaires
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les membres du groupe
Write-Host "--- Membres de GroupeFormation ---"
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Host "$($_.Prenom) $($_.Nom)"
}
