# utilisateurs4.ps1
$WorkPath = "C:\Temp"
if (-not (Test-Path $WorkPath)) {
    New-Item -ItemType Directory -Path $WorkPath -Force | Out-Null
}

Write-Host "`n=== EXERCICE 4 ===" -ForegroundColor Cyan

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"}
)

$CsvPath = "$WorkPath\UsersSimules.csv"
$Users | ForEach-Object { [PSCustomObject]$_ } | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8
Write-Host "Exporté : $CsvPath" -ForegroundColor Yellow

$ImportedUsers = Import-Csv -Path $CsvPath
Write-Host "`nUtilisateurs importés :" -ForegroundColor Yellow
$ImportedUsers | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom)"
}

$ImportGroupe = @{
    "NomGroupe" = "ImportGroupe"
    "Membres" = @()
}
$ImportGroupe["Membres"] += $ImportedUsers

Write-Host "`nGroupe '$($ImportGroupe.NomGroupe)' créé avec $($ImportGroupe.Membres.Count) membres." -ForegroundColor Green

Write-Host "`n`n=== MINI-PROJET ===" -ForegroundColor Magenta

$UsersPromo = @(
    @{Nom="Rousseau"; Prenom="Julien"; Login="jrousseau"; OU="Promo2025"},
    @{Nom="Petit"; Prenom="Emma"; Login="epetit"; OU="Promo2025"},
    @{Nom="Moreau"; Prenom="Lucas"; Login="lmoreau"; OU="Promo2025"},
    @{Nom="Simon"; Prenom="Léa"; Login="lsimon"; OU="Promo2025"},
    @{Nom="Laurent"; Prenom="Hugo"; Login="hlaurent"; OU="Promo2025"}
)

Write-Host "`nUtilisateurs Promo2025 :" -ForegroundColor Cyan
$UsersPromo | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom) ($($_.Login))" -ForegroundColor White
}

$Groupe = @{
    "NomGroupe" = "Etudiants2025"
    "Description" = "Groupe des étudiants de la promotion 2025"
    "Membres" = @()
}

$UsersPromo | ForEach-Object {
    $Groupe["Membres"] += $_
}

Write-Host "`nGroupe '$($Groupe.NomGroupe)' créé." -ForegroundColor Cyan
Write-Host "Description : $($Groupe.Description)" -ForegroundColor Gray

Write-Host "`nMembres du groupe :" -ForegroundColor Cyan
$Groupe["Membres"] | ForEach-Object {
    Write-Host "  ✓ $($_.Prenom) $($_.Nom) - $($_.Login)" -ForegroundColor Green
}

$ExportPath = "$WorkPath\Etudiants2025.csv"
$Groupe["Membres"] | ForEach-Object { [PSCustomObject]$_ } | Export-Csv -Path $ExportPath -NoTypeInformation -Encoding UTF8

Write-Host "`nExport final : $ExportPath" -ForegroundColor Yellow

Write-Host "`n=== RÉSUMÉ ===" -ForegroundColor Magenta
Write-Host "✓ Utilisateurs créés : $($UsersPromo.Count)" -ForegroundColor Green
Write-Host "✓ Groupe : $($Groupe.NomGroupe)" -ForegroundColor Green
Write-Host "✓ Membres : $($Groupe.Membres.Count)" -ForegroundColor Green
Write-Host "✓ CSV exporté : $ExportPath" -ForegroundColor Green
Write-Host "`nTerminé ! 🎉" -ForegroundColor Cyan















