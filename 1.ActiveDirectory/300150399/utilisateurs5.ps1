# utilisateurs5.ps1
# Mini-projet : Promo2025 -> Etudiants2025 + export CSV

$Users = @(
    @{Nom="Durand";   Prenom="Lea";     Login="ldurand";   OU="Promo2025"},
    @{Nom="Moreau";   Prenom="Yanis";   Login="ymoreau";   OU="Promo2025"},
    @{Nom="Petit";    Prenom="Ines";    Login="ipetit";    OU="Promo2025"},
    @{Nom="Garnier";  Prenom="Ayman";   Login="agarnier";  OU="Promo2025"},
    @{Nom="Robert";   Prenom="Maya";    Login="mrobert";   OU="Promo2025"}
)

$Groups = @{}
$Groups["Etudiants2025"] = @()
$Groups["Etudiants2025"] += $Users | Where-Object { $_.OU -eq "Promo2025" }

$export = "C:\Temp\Etudiants2025.csv"
$null = New-Item -ItemType Directory -Path (Split-Path $export) -Force

$Groups["Etudiants2025"] |
    Select-Object Prenom,Nom,Login,OU |
    Export-Csv -Path $export -NoTypeInformation -Encoding UTF8

"Export terminé -> $export"
