# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation
# Import du CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

# Création du groupe
$Groups["ImportGroupe"] = @()

# Ajout des utilisateurs importés
$Groups["ImportGroupe"] += $ImportedUsers
