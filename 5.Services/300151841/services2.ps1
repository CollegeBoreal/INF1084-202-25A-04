# Afficher les 20 derniers événements NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Afficher les logs du système (Netlogon)
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Journal moderne (Event Viewer v2)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
