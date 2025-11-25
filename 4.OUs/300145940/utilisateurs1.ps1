# Script préparé par : Tasnim (300145940)
# Objectif : Simulation de gestion d'utilisateurs et de groupes

# Étape 1 – Définition de plusieurs utilisateurs fictifs avec leurs attributs
$Users = @(
    @{Nom="Martin";  Prenom="Jean";   Login="jmartin";  OU="Stagiaires"},
    @{Nom="Bouchard";Prenom="Sofia";  Login="sbouchard";OU="Stagiaires"},
    @{Nom="Hassan";  Prenom="Omar";   Login="ohassan";  OU="Stagiaires"},
    @{Nom="Ngoma";   Prenom="Kevin";  Login="kngoma";   OU="Stagiaires"},
    @{Nom="Tremblay";Prenom="Chloe";  Login="ctremblay";OU="Stagiaires"}
)

# Affichage résumé de chaque utilisateur pour vérification rapide
$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

# Étape 2 – Création de deux groupes destinés à recevoir des membres
$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD"   = @()
}

# Ajout automatique des stagiaires dans le groupe 'GroupeFormation'
$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

# Étape 3 – Filtrer tous les utilisateurs dont le prénom contient la lettre “a”
Write-Host "`nUtilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" }

# Étape 4 – Export des utilisateurs vers un fichier CSV dans C:\Temp
if (!(Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "`nExport réalisé vers : $Path"

# Étape 5 – Création d’une nouvelle promotion d’étudiants (Promo 2025)
$Promo2025 = @(
    @{Nom="Diallo"; Prenom="Amina"; Login="adiallo"; OU="Promo2025"},
    @{Nom="Fortin"; Prenom="Marc";  Login="mfortin"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Chloe"; Login="cgagnon"; OU="Promo2025"},
    @{Nom="Perez";  Prenom="Luc";   Login="lperez";  OU="Promo2025"},
    @{Nom="Roy";    Prenom="Nora";  Login="nroy";    OU="Promo2025"}
)

# Stockage des étudiants 2025 dans un tableau séparé puis export CSV
$Etudiants2025 = @()
$Etudiants2025 += $Promo2025

$PromoPath = "C:\Temp\Etudiants2025.csv"
$Etudiants2025 | Export-Csv -Path $PromoPath -NoTypeInformation
Write-Host "`nExport réalisé vers : $PromoPath"

