# Créer une liste d'utilisateurs simulés
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Martin"; Prenom="Lucas"; Login="lmartin"; OU="Stagiaires"},
    @{Nom="Bernard"; Prenom="Emma"; Login="ebernard"; OU="Stagiaires"}
)

# Créer le dossier C:\Temp s'il n'existe pas
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory
}

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation
Write-Host "Export effectué vers C:\Temp\UsersSimules.csv"

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Créer un groupe "ImportGroupe"
$ImportGroupe = @()

# Ajouter tous les utilisateurs importés
$ImportedUsers | ForEach-Object {
    $ImportGroupe += $_
}

# Afficher les membres du groupe
Write-Host "`nMembres de ImportGroupe :"
$ImportGroupe | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login)" }