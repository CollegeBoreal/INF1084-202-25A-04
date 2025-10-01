. .\Utilisateur1.ps1
# Créer des groupes
$Groups = @{
    "GroupeFormation" = @();
    "ProfesseursAD" = @()
}

# Ajouter un utilisateur à un groupe
$Groups["GroupeFormation"] += $Users[0]   # Alice Dupont
# Ajouter tous les stagiaires
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    $Groups["GroupeFormation"] += $_
}
# Afficher les membres du groupe
$Groups["GroupeFormation"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - OU: $($_.OU)" }

