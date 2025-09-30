New-Item -ItemType Directory -Path "C:\Temp" -Force
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
$ImportedUsers
$Groups = @{
    "ImportGroupe" = @()
}

$Groups["ImportGroupe"] += $ImportedUsers
$Groups["ImportGroupe"]

