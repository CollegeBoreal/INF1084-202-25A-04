# 4?? Export et import CSV

# Exporter les utilisateurs simulés
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation

# Importer depuis CSV
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers

# Exercice : Importer le fichier CSV et créer un groupe "ImportGroupe" en ajoutant tous les utilisateurs importés.
