. ./utilisateurs1.ps1

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path ".\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path ".\UsersSimules.csv"
$ImportedUsers
