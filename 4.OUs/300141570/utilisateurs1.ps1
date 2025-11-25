# Auteur : Haroune Berkani (300141570)

# Step 1
$Users = @(
    @{Nom="Martin";  Prenom="Jean";   Login="jmartin";  OU="Stagiaires"},
    @{Nom="Bouchard";Prenom="Sofia";  Login="sbouchard";OU="Stagiaires"},
    @{Nom="Hassan";  Prenom="Omar";   Login="ohassan";  OU="Stagiaires"},
    @{Nom="Ngoma";   Prenom="Kevin";  Login="kngoma";   OU="Stagiaires"},
    @{Nom="Tremblay";Prenom="Chloe";  Login="ctremblay";OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Step 2
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Step 3
Write-Host "`nUtilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" }

# Step 4
if (!(Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "`nExporté vers : $Path"

# Step 5
$Promo2025 = @(
    @{Nom="Diallo"; Prenom="Amina"; Login="adiallo"; OU="Promo2025"},
    @{Nom="Fortin"; Prenom="Marc";  Login="mfortin"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Chloe"; Login="cgagnon"; OU="Promo2025"},
    @{Nom="Perez";  Prenom="Luc";   Login="lperez";  OU="Promo2025"},
    @{Nom="Roy";    Prenom="Nora";  Login="nroy";   OU="Promo2025"}
)

$Etudiants2025 = @()
$Etudiants2025 += $Promo2025

$PromoPath = "C:\Temp\Etudiants2025.csv"
$Etudiants2025 | Export-Csv -Path $PromoPath -NoTypeInformation
Write-Host "`nExporté vers : $PromoPath"
