# utilisateurs2.ps1

$liste = "Karim,BENZEMA;Nabil,FEKIR;Hakim,ZIYECH;Achraf,HAKIMI;Yassine,BOUNOU"

$personnes = @()
foreach ($entry in $liste.Split(";")) {
    $data = $entry.Split(",")
    $personnes += [PSCustomObject]@{Prenom=$data[0]; Nom=$data[1]}
}

$resultats = $personnes | Where-Object { $_.Prenom -like "*a*" }

Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$resultats | ForEach-Object { Write-Host "$($_.Prenom) $($_.Nom)" }
