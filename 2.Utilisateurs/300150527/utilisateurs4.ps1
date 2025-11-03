Clear-Host

$Users = @(
    @{ Nom="Dupont";  Prenom="Alice";  Login="alice01";  OU="Stagiaires" },
    @{ Nom="Lemoine"; Prenom="Sarah";  Login="sarah02";  OU="Stagiaires" },
    @{ Nom="Benali";  Prenom="Karim";  Login="karim03";  OU="Stagiaires" },
    @{ Nom="Bouraoui"; Prenom="Akrem"; Login="akrem04";  OU="Stagiaires" },
    @{ Nom="Neymar";  Prenom="Jr";     Login="neymar05"; OU="Stagiaires" }
)


$csvPath = "C:\Users\hp-01\Documents\INF1084-202-25A-04\2.Utilisateurs\_scripts\UsersSimules.csv"
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
Write-Host "`nUtilisateurs exportés vers $csvPath"

$ImportedUsers = Import-Csv -Path $csvPath


$Groups = @{ "ImportGroupe" = @() }
$Groups["ImportGroupe"] += $ImportedUsers


Write-Host "`n--- Membres du groupe ImportGroupe ---"
$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }

