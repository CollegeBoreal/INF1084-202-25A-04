# --- utilisateurs4.ps1 ---
# Jeu d'utilisateurs de base
$Users = @(
    @{Nom="Dupont";  Prenom="Alice";  Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah";  Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim";  Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Nora";   Login="nmartin";  OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Amine";  Login="abernard"; OU="Stagiaires"}
)

# 4) Exporter vers CSV
$csvPath = "C:\Temp\UsersSimules.csv"
$null = New-Item -ItemType Directory -Path (Split-Path $csvPath) -ErrorAction SilentlyContinue
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
"Exporté vers $csvPath"

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path $csvPath
"--- Utilisateurs importés ---"
$ImportedUsers | Format-Table -AutoSize

# Exercice 4 : créer ImportGroupe et y ajouter tous les importés
$Groups = @{ "ImportGroupe" = @() }
$Groups["ImportGroupe"] += $ImportedUsers
"--- Contenu ImportGroupe ---"
$Groups["ImportGroupe"] | Select Prenom, Nom, Login, OU | Format-Table -AutoSize

# 5) Mini-projet
#   - Créer 5 utilisateurs dans OU "Promo2025"
#   - Créer groupe "Etudiants2025" et y ajouter ces utilisateurs
#   - Exporter la liste finale du groupe en CSV

$PromoUsers = @(
    @{Nom="Roche";     Prenom="Lina";    Login="lroche";    OU="Promo2025"},
    @{Nom="Moreau";    Prenom="Omar";    Login="omoreau";   OU="Promo2025"},
    @{Nom="Girard";    Prenom="Samir";   Login="sgirard";   OU="Promo2025"},
    @{Nom="Pelletier"; Prenom="Maya";    Login="mpelletier";OU="Promo2025"},
    @{Nom="Fabre";     Prenom="Yanis";   Login="yfabre";    OU="Promo2025"}
)

$Groups["Etudiants2025"] = @()
$Groups["Etudiants2025"] += $PromoUsers

"--- Etudiants2025 ---"
$Groups["Etudiants2025"] | Select Prenom, Nom, Login, OU | Format-Table -AutoSize

# Export final du groupe
$csvPromo = "C:\Temp\Etudiants2025.csv"
$Groups["Etudiants2025"] | Select Prenom,Nom,Login,OU | Export-Csv -Path $csvPromo -NoTypeInformation -Encoding UTF8
"Export du groupe Etudiants2025 vers $csvPromo"

# ===============================
# MINI-PROJET : Simulation Promo2025
# ===============================

# Créer 5 utilisateurs dans OU "Promo2025"
$PromoUsers = @(
    @{Nom="Roche";     Prenom="Lina";    Login="lroche";     OU="Promo2025"},
    @{Nom="Moreau";    Prenom="Omar";    Login="omoreau";    OU="Promo2025"},
    @{Nom="Girard";    Prenom="Samir";   Login="sgirard";    OU="Promo2025"},
    @{Nom="Pelletier"; Prenom="Maya";    Login="mpelletier"; OU="Promo2025"},
    @{Nom="Fabre";     Prenom="Yanis";   Login="yfabre";     OU="Promo2025"}
)

# Créer le groupe Etudiants2025
$Groups["Etudiants2025"] = @()

# Ajouter tous les utilisateurs Promo2025 dans ce groupe
$Groups["Etudiants2025"] += $PromoUsers

# Afficher le groupe
"--- Contenu du groupe Etudiants2025 ---"
$Groups["Etudiants2025"] | Format-Table -AutoSize

# Exporter le groupe en CSV
$csvPromo = "C:\Temp\Etudiants2025.csv"
$Groups["Etudiants2025"] | Select Prenom,Nom,Login,OU | Export-Csv -Path $csvPromo -NoTypeInformation -Encoding UTF8
"Export du groupe Etudiants2025 vers $csvPromo"

