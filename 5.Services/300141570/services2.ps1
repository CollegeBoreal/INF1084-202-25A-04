# Auteur : Haroune Berkani (300141570)

# Step 1 : Afficher les 20 derniers événements liés au service NTDS
Get-EventLog -LogName "Directory Service" -Newest 20

# Step 2 : Afficher les événements système liés au service Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

# Step 3 : Afficher les événements via le journal moderne (Get-WinEvent)
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
