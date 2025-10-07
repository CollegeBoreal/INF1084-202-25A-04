# utilisateurs4.ps1
# Matricule: 300150284
$Matricule = "300150284"
$ExportDir = "C:\TP_AD_$Matricule"
if (-not (Test-Path $ExportDir)) { New-Item -ItemType Directory -Path $ExportDir | Out-Null }

# Créer 5 utilisateurs simulés pour Promo2025
$PromoUsers = @(
    [PSCustomObject]@{Nom="Carpentier"; Prenom="Julie";   Login="jcarpentier"; OU="Promo2025"},
    [PSCustomObject]@{Nom="Rousseau";   Prenom="Thomas";  Login="trousseau";   OU="Promo2025"},
    [PSCustomObject]@{Nom="Khan";       Prenom="Sara";    Login="skhan";       OU="Promo2025"},
    [PSCustomObject]@{Nom="Gagnon";     Prenom="Marc";    Login="mgagnon";     OU="Promo2025"},
    [PSCustomObject]@{Nom="Souleymane"; Prenom="Ibrahim"; Login="isouleymane"; OU="Promo2025"}
)

# Créer groupe Etudiants2025 et y ajouter les utilisateurs de Promo2025
$Groups = $Groups ?? @{}
$Groups["Etudiants2025"] = $PromoUsers

# Exporter la liste finale du groupe
$exportPath = Join-Path $ExportDir "Etudiants2025_$Matricule.csv"
$Groups["Etudiants2025"] | Export-Csv -Path $exportPath -NoTypeInformation -Encoding UTF8

Write-Host "Groupe 'Etudiants2025' créé avec $($Groups['Etudiants2025'].Count) membres."
Write-Host "Export CSV -> $exportPath"

