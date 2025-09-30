# Exercice 4 : Export CSV, Import CSV, créer ImportGroupe
$Users = @(
    @{Nom="Dupont";  Prenom="Alice"; Login="adupont";  OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali";  Prenom="Karim"; Login="kbenali";  OU="Stagiaires"},
    @{Nom="Martin";  Prenom="Jean";  Login="jmartin";  OU="Stagiaires"},
    @{Nom="Nguyen";  Prenom="Lina";  Login="lnguyen";  OU="Stagiaires"}
)

if (-not (Test-Path "C:\Temp")) { New-Item -ItemType Directory -Path "C:\Temp" | Out-Null }

$csvPath = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
"Export effectué vers: $csvPath"

$ImportedUsers = Import-Csv -Path $csvPath
"=== Utilisateurs importés ==="
$ImportedUsers

$Groups = @{ "ImportGroupe" = @() }
$Groups["ImportGroupe"] += $ImportedUsers

"=== Membres d'ImportGroupe ==="
$Groups["ImportGroupe"] | ForEach-Object {
    "{0} {1} - Login: {2} - OU: {3}" -f $_.Prenom, $_.Nom, $_.Login, $_.OU
}
