Write-Host "`n--- Script utilisateurs4.ps1 : Export/Import CSV et groupe ---"

# Créer une liste d'utilisateurs (autonome)
$Users = @(
    @{Nom="Dupont"; Prenom="Alice"; Login="adupont"; OU="Stagiaires"},
    @{Nom="Lemoine"; Prenom="Sarah"; Login="slemoine"; OU="Stagiaires"},
    @{Nom="Benali"; Prenom="Karim"; Login="kbenali"; OU="Stagiaires"},
    @{Nom="Diallo"; Prenom="Moussa"; Login="mdiallo"; OU="Stagiaires"},
    @{Nom="Nguyen"; Prenom="Linh"; Login="lnguyen"; OU="Stagiaires"}
)

# Convertir les hash tables en objets PSObject pour Export-Csv
$UsersObjects = $Users | ForEach-Object { 
    [PSCustomObject]@{
        Nom    = $_.Nom
        Prenom = $_.Prenom
        Login  = $_.Login
        OU     = $_.OU
    }
}

# Définir le chemin CSV dans le même dossier que le script
$ScriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$CsvPath = Join-Path -Path $ScriptFolder -ChildPath "UsersSimules.csv"

# Exporter les utilisateurs simulés
$UsersObjects | Export-Csv -Path $CsvPath -NoTypeInformation
Write-Host "`nExport CSV terminé : $CsvPath"

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path $CsvPath

# Créer un groupe "ImportGroupe" et ajouter tous les utilisateurs importés
$ImportGroupe = @()
$ImportGroupe += $ImportedUsers

# Afficher les membres du groupe importé
Write-Host "`nMembres du groupe ImportGroupe :"
$ImportGroupe | ForEach-Object {
    "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)"
}

