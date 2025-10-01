# utilisateurs4.ps1
$csvPath = "C:\Temp\UsersSimules.csv"

# Export
$Users | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

# Import
$ImportedUsers = Import-Csv -Path $csvPath

# Créer groupe et ajouter importés
$Groups["ImportGroupe"] = @()
$Groups["ImportGroupe"] += $ImportedUsers

"== Membres ImportGroupe =="
$Groups["ImportGroupe"] | Format-Table Prenom,Nom,Login,OU
