# Importer les utilisateurs
. .\Utilisateur1.ps1   # (le point-espace signifie "exécuter dans le même contexte")

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter les stagiaires
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les résultats
Write-Output "=== GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Output "$($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}
