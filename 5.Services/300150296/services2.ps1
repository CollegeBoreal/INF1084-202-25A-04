# TP Services AD - Étape 2 : Afficher les événements des services AD
# Étudiant : 300150296

Write-Host "=== Événements du Directory Service ===" -ForegroundColor Green

# Afficher les 20 derniers événements liés à NTDS
Get-EventLog -LogName "Directory Service" -Newest 20 | 
Select-Object TimeGenerated, EntryType, Source, Message | 
Format-Table -AutoSize

Write-Host "`n=== Événements Netlogon ===" -ForegroundColor Cyan

# Afficher les logs du système
Get-EventLog -LogName "System" -Newest 20 | 
Where-Object {$_.Source -eq "Netlogon"} |
Select-Object TimeGenerated, EntryType, Message |
Format-Table -AutoSize

Write-Host "`n=== Événements via Get-WinEvent ===" -ForegroundColor Yellow

# Méthode moderne
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | 
Select-Object TimeCreated, Id, LevelDisplayName, Message |
Format-Table -AutoSize