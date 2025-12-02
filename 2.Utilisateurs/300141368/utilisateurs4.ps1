# utilisateurs4.ps1
#  Exercice 4 : Export CSV, import, et création d'un groupe avec les utilisateurs importés

#  Import des utilisateurs
. .\utilisateurs1.ps1

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers