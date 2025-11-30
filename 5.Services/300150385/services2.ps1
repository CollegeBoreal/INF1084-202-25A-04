# Afficher les 20 derniers événements liés au Directory Service (NTDS)
Get-EventLog -LogName "Directory Service" -Newest 20

# Logs système liés à Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object { $_.Source -eq "Netlogon" }

# Version moderne des logs AD
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
