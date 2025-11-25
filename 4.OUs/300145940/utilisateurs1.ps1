# Script préparé par : Tasnim (300145940)
# Objectif : Simulation de gestion d'utilisateurs et de groupes

# Étape 1 – Liste d'utilisateurs modifiée avec nouveaux noms
$Users = @(
    @{Nom="Lefebvre"; Prenom="Alex";    Login="alefebvre"; OU="Stagiaires"},
    @{Nom="Moreau";   Prenom="Leila";   Login="lmoreau";   OU="Stagiaires"},
    @{Nom="Benali";   Prenom="Yasmine"; Login="ybenali";   OU="Stagiaires"},
    @{Nom="Durand";   Prenom="Hugo";    Login="hdurand";   OU="Stagiaires"},
    @{Nom="Khelifa";  Prenom="Maya";    Login="mkhelifa";  OU="Stagiaires"}
)

# Aperçu des utilisateurs pour vérification
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Étape 2 – Création des groupes
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajout des stagiaires dans GroupeFormation
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Étape 3 – Filtrer prénoms contenant "a"
Write-Host "`nUtilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" }

# Étape 4 – Export CSV users
if (!(Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "`nExporté vers : $Path"

# Étape 5 – Promo 2025 mise à jour
$Promo2025 = @(
    @{Nom="Said";    Prenom="Nadia";  Login="nsaid";   OU="Promo2025"},
    @{Nom="Lambert"; Prenom="Louis";  Login="llambert";OU="Promo2025"},
    @{Nom="Caron";   Prenom="Ines";   Login="icaroon"; OU="Promo2025"},
    @{Nom="Messaoud";Prenom="Sarah";  Login="smessaoud";OU="Promo2025"},
    @{Nom="Bernier"; Prenom="Eliot";  Login="ebernier"; OU="Promo2025"}
)

$Etudiants2025 = @()
$Etudiants2025 += $Promo2025

$PromoPath = "C:\Temp\Etudiants2025.csv"
$Etudiants2025 | Export-Csv -Path $PromoPath -NoTypeInformation
Write-Host "`nExporté vers : $PromoPath"

