# Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajout de tous les utilisateurs de l'OU "Stagiaires"
$Groups["GroupeFormation"] += $Users | Where-Object {$_.OU -eq "Stagiaires"}
