# Mini-projet : Promo2025, groupe Etudiants2025, export CSV
$Users = @(
    @{Nom="Durand"; Prenom="Maya";  Login="mdurand"; OU="Promo2025"},
    @{Nom="Caron";  Prenom="Yanis"; Login="ycaron";  OU="Promo2025"},
    @{Nom="Haddad"; Prenom="Nora";  Login="nhaddad"; OU="Promo2025"},
    @{Nom="Khan";   Prenom="Ayman"; Login="akhan";   OU="Promo2025"},
    @{Nom="Rossi";  Prenom="Clara"; Login="crossi";  OU="Promo2025"}
)
$Groups = @{ "Etudiants2025" = @() }
$Groups["Etudiants2025"] += ($Users | Where-Object { $_.OU -eq "Promo2025" })

"=== Membres d'Etudiants2025 ==="
$Groups["Etudiants2025"] | ForEach-Object {
  "{0} {1} ({2}) - OU: {3}" -f $_.Prenom, $_.Nom, $_.Login, $_.OU
}

if (-not (Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" | Out-Null }
$csv = "C:\Temp\Etudiants2025.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $csv -NoTypeInformation -Encoding UTF8
"Export du groupe effectué vers: $csv"
