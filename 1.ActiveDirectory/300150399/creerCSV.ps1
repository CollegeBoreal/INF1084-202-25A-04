# creerCSV.ps1
# Crée une liste d'utilisateurs et l'exporte en CSV (C:\Temp\UsersSimules.csv)

$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Boucher"; Prenom="Amine";  Login="aboucher"; OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nadia";  Login="nmartin";  OU="Stagiaires"}
)

$csvPath = "C:\Temp\UsersSimules.csv"
$null = New-Item -ItemType Directory -Path (Split-Path $csvPath) -Force
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
Write-Host "CSV créé -> $csvPath"
