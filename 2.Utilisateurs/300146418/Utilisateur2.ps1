# Importer la liste d'utilisateurs (exécuter Ikram1.ps1 dans le même contexte)
. .\Utilisateur1.ps1

# Créer des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajouter tous les stagiaires dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Afficher les résultats
Write-Output "=== GroupeFormation ==="
$Groups["GroupeFormation"] | ForEach-Object {
    Write-Output "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

