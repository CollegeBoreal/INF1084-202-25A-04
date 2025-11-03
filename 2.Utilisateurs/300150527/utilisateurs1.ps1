Clear-Host

$Users = @(
    @{ Nom="Dupont";  Prenom="Alice";  Login="alice01";  OU="Stagiaires" },
    @{ Nom="Lemoine"; Prenom="Sarah";  Login="sarah02";  OU="Stagiaires" },
    @{ Nom="Benali";  Prenom="Karim";  Login="karim03";  OU="Stagiaires" },
    @{ Nom="Bouraoui"; Prenom="Akrem"; Login="akrem04";  OU="Stagiaires" },
    @{ Nom="Neymar";  Prenom="Jr";     Login="neymar05"; OU="Stagiaires" }
)

Write-Host "`n--- Liste des utilisateurs ---"
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

Write-Host "`n--- Comptage par OU ---"
$Users | Group-Object OU | Select-Object Name, Count | Format-Table -AutoSize

