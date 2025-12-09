# utilisateurs4.ps1

$equipes = "GroupeFormation,GroupeRH"

$donnees = @(
    "Karim|BENZEMA|Stagiaires",
    "Nabil|FEKIR|Professeurs",
    "Hakim|ZIYECH|Stagiaires",
    "Achraf|HAKIMI|Stagiaires",
    "Yassine|BOUNOU|Employés"
)

Write-Host "`nAjout des stagiaires dans le groupe GroupeFormation :"

foreach ($ligne in $donnees) {
    $info = $ligne.Split("|")
    if ($info[2] -eq "Stagiaires") {
        Write-Host " - $($info[0]) $($info[1]) ajouté à GroupeFormation"
    }
}
