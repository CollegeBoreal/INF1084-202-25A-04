# Exercice 4 : Mini-projet complet
# Étudiant : 300150296

$Users = @(
    @{Nom="Tremblay"; Prenom="Marie"; Login="mtremblay"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Pierre"; Login="pgagnon"; OU="Promo2025"},
    @{Nom="Roy"; Prenom="Sophie"; Login="sroy"; OU="Promo2025"},
    @{Nom="Côté"; Prenom="Jean"; Login="jcote"; OU="Promo2025"},
    @{Nom="Bouanani"; Prenom="Youba"; Login="ybouanani"; OU="Promo2025"}
)

Write-Host "=== Utilisateurs créés ===" -ForegroundColor Green
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - $($_.OU)" }

$Groups = @{"Etudiants2025" = @()}
$Users | Where-Object {$_.OU -eq "Promo2025"} | ForEach-Object {
    $Groups["Etudiants2025"] += $_
}

Write-Host "`n=== Groupe Etudiants2025 ===" -ForegroundColor Cyan
$Groups["Etudiants2025"] | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - $($_.Login)"
}

$ExportPath = "Etudiants2025_300150296.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $ExportPath -NoTypeInformation -Encoding UTF8
Write-Host "`n=== Export réussi : $ExportPath ===" -ForegroundColor Yellow