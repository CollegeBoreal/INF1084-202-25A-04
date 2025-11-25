 creat folder C:\Temp s'il n'existe pas
if (-not (Test-Path -Path "C:\Temp")) { 
   New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}
# Export users
$Users | Export-Csv -Path "C:\Temp\UsersSimules.csv" -NoTypeInformation -Encoding UTF8
# import users
$ImportedUsers = Import-Csv -Path "C:\Temp\UsersSimules.csv"
# Show the users
Write-Host "Utilisateurs importés depuis le CSV :" -ForegroundColor Cyan

$ImportedUsers | Format-Table -AutoSize
