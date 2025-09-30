# Exercice 5 : Mini-projet Promo2025
$Promo2025 = @(
    @{Nom="Diallo";     Prenom="Aminata"; Login="adiallo";    OU="Promo2025"},
    @{Nom="Nguyen";     Prenom="Bao";     Login="bnguyen";    OU="Promo2025"},
    @{Nom="Fernandez";  Prenom="Lucia";   Login="lfernandez"; OU="Promo2025"},
    @{Nom="Haddad";     Prenom="Youssef"; Login="yhaddad";    OU="Promo2025"},
    @{Nom="Zhang";      Prenom="Mei";     Login="mzhang";     OU="Promo2025"}
)

$Groups = @{}
$Groups["Etudiants2025"] = @()
$Groups["Etudiants2025"] += $Promo2025

New-Item -ItemType Directory -Path "C:\Temp" -Force | Out-Null

$Groups["Etudiants2025"] | ForEach-Object { [pscustomobject]$_ } |
    Export-Csv -Path "C:\Temp\Etudiants2025.csv" -NoTypeInformation -Encoding UTF8

"Etudiants2025 - membres : $($Groups["Etudiants2025"].Count)"
$Groups["Etudiants2025"] | ForEach-Object { [pscustomobject]$_ } | Format-Table Prenom, Nom, Login, OU
"CSV écrit : C:\Temp\Etudiants2025.csv"
