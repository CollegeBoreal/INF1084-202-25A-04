# utilisateurs3.ps1
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Thomas"; Login="tmartin"; OU="Stagiaires"},
    @{Nom="Garcia"; Prenom="Marie"; Login="mgarcia"; OU="Professeurs"},
    @{Nom="hammiche"; Prenom="hacen"; Login="hm"; OU="psycholouge"},
    @{Nom="rabia"; Prenom="bouhali"; Login="rabi3"; OU="Professeurs"},
    @{Nom="Bernard"; Prenom="Antoine"; Login="abernard"; OU="Stagiaires"}
)

Write-Host "`n=== Noms avec 'B' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.Nom -like "B*"} | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom)" -ForegroundColor Yellow
}

Write-Host "`n=== OU Stagiaires ===" -ForegroundColor Cyan
$Users | Where-Object {$_.OU -eq "Stagiaires"} | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom)" -ForegroundColor Yellow
}

Write-Host "`n=== Prénoms avec 'a' ===" -ForegroundColor Cyan
$Users | Where-Object {$_.Prenom -like "*a*"} | ForEach-Object {
    Write-Host "  - $($_.Prenom) $($_.Nom)" -ForegroundColor Green
}

$NombreAvecA = ($Users | Where-Object {$_.Prenom -like "*a*"}).Count
Write-Host "`nTotal avec 'a' : $NombreAvecA" -ForegroundColor Magenta




