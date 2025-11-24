
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Tremblay"; Prenom="Louis"; Login="ltremblay"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

$Users | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

$Groups = @{
    "GroupeFormation" = @()
    "ProfesseursAD" = @()
}

$Groups["GroupeFormation"] += $Users | Where-Object { $_.OU -eq "Stagiaires" }

Write-Host "`nUtilisateurs dont le prénom contient 'a' :"
$Users | Where-Object { $_.Prenom -match "a" }

$Path = "C:\Temp\UsersSimules.csv"
$Users | Export-Csv -Path $Path -NoTypeInformation
Write-Host "`nExporté vers : $Path"

$Promo2025 = @(
    @{Nom="Diallo"; Prenom="Amina"; Login="adiallo"; OU="Promo2025"},
    @{Nom="Fortin"; Prenom="Marc"; Login="mfortin"; OU="Promo2025"},
    @{Nom="Gagnon"; Prenom="Chloé"; Login="cgagnon"; OU="Promo2025"},
    @{Nom="Perez"; Prenom="Luc"; Login="lperez"; OU="Promo2025"},
    @{Nom="Roy"; Prenom="Nora"; Login="nroy"; OU="Promo2025"}
)

$Etudiants2025 = @()
$Etudiants2025 += $Promo2025

$PromoPath = "C:\Temp\Etudiants2025.csv"
$Etudiants2025 | Export-Csv -Path $PromoPath -NoTypeInformation
Write-Host "`nExporté vers : $PromoPath"

