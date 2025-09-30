Clear-Host

$Users = @(
    @{ Nom="Dupont";  Prenom="Alice";  Login="alice01";  OU="Stagiaires" },
    @{ Nom="Lemoine"; Prenom="Sarah";  Login="sarah02";  OU="Stagiaires" },
    @{ Nom="Benali";  Prenom="Karim";  Login="karim03";  OU="Stagiaires" },
    @{ Nom="Bouraoui"; Prenom="Akrem"; Login="akrem04";  OU="Stagiaires" },
    @{ Nom="Neymar";  Prenom="Jr";     Login="neymar05"; OU="Stagiaires" }
)

$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

$stagiaires = $Users | Where-Object { $_.OU -eq "Stagiaires" }
$Groups["GroupeFormation"] += $stagiaires

Write-Host "`n--- Liste des groupes et membres ---"
$Groups.GetEnumerator() | ForEach-Object {
    $membres = ($_.Value | ForEach-Object { "$($_.Prenom) $($_.Nom)" }) -join ", "
    Write-Host "Groupe: $($_.Key) - Membres: $membres"
}

