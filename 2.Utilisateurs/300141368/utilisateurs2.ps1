
# Exercice 2 : Ajouter les utilisateurs "Stagiaires" dans "GroupeFormation"

#  Import des utilisateurs
. .\utilisateurs1.ps1

# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

# Ajouter tous les utilisateurs de l'OU "Stagiaires" dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Affichage du groupe
Write-Host "`n👥 Membres de GroupeFormation :"
$Groups["GroupeFormation"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom)"
}
