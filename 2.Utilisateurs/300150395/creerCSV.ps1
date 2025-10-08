# creerCSV.ps1
# Créer le fichier UsersSimules.csv pour le mini-projet

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Promo2025"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Promo2025"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Promo2025"},
    @{Nom="Moulin"; Prenom="Jean"; Login="jmoulin"; OU="Promo2025"},
    @{Nom="Trache"; Prenom="Ismail"; Login="ismailt"; OU="Promo2025"}
)

# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path "C:\Temp")) { 
    New-Item -Path "C:\Temp" -ItemType Directory 
}

# Exporter les utilisateurs en CSV
$Users | ForEach-Object {
    [PSCustomObject]@{
        Nom = $_.Nom
        Prenom = $_.Prenom
        Login = $_.Login
        OU = $_.OU
    }
} | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

Write-Host "✅ CSV créé avec succès : C:\Temp\UsersSimules.csv"

