Clear-Host

$Users = @(
    @{ Nom="Dupont";  Prenom="Alice";  Login="alice01";  OU="Stagiaires" },
    @{ Nom="Lemoine"; Prenom="Sarah";  Login="sarah02";  OU="Stagiaires" },
    @{ Nom="Benali";  Prenom="Karim";  Login="karim03";  OU="Stagiaires" },
    @{ Nom="Bouraoui"; Prenom="Akrem"; Login="akrem04";  OU="Stagiaires" },
    @{ Nom="Neymar";  Prenom="Jr";     Login="neymar05"; OU="Stagiaires" }
)

Write-Host "`n--- Utilisateurs dont le NOM commence par B ---"
$Users | Where-Object { $_.Nom -like "B*" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

Write-Host "`n--- Utilisateurs dans l'OU Stagiaires ---"
$Users | Where-Object { $_.OU -eq "Stagiaires" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

Write-Host "`n--- Utilisateurs dont le PRENOM contient 'a' ---"
$Users | Where-Object { $_.Prenom -match "a" } | ForEach-Object { "$($_.Prenom) $($_.Nom)" }

