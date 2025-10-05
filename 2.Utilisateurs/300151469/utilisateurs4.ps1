$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"

$Groups["ImportGroupe"] = @()
$Groups["ImportGroupe"] += $ImportedUsers

$Groups["ImportGroupe"] | ForEach-Object { "$($_.Prenom) $($_.Nom) - Login: $($_.Login) - OU: $($_.OU)" }

