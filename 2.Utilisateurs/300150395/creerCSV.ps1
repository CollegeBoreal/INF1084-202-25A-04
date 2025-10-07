# creerCSV.ps1
# Créer le fichier UsersSimules.csv pour l'exercice 4

$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Moulin"; Prenom="Jean"; Login="jmoulin"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Paul"; Login="pmartin"; OU="Informatique"}
)

# Créer le dossier C:\Temp si il n'existe pas
if (-not (Test-Path "C:\Temp")) { New-Item -Path "C:\Temp" -ItemType Directory }

# Exporter les utilisateurs en CSV
$Users | ForEach-Object {
    [PSCustomObject]@{
        Nom = $_.Nom
        Prenom = $_.Prenom
        Login = $_.Login
        OU = $_.OU
    }
} | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

Write-Host "CSV créé avec succès : C:\Temp\UsersSimules.csv"

