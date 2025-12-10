# utilisateurs3.ps1

$prenoms = @("Karim", "Nabil", "Hakim", "Achraf", "Yassine")
$noms = @("BENZEMA", "FEKIR", "ZIYECH", "HAKIMI", "BOUNOU")

$selection = for ($i = 0; $i -lt $prenoms.Count; $i++) {
    if ($prenoms[$i] -match "a") {
        "$($prenoms[$i]) $($noms[$i])"
    }
}

Write-Host "`nUtilisateurs dont le prénom contient la lettre 'a' :"
$selection | ForEach-Object { Write-Host $_ }
