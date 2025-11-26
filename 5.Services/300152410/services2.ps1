# services2.ps1
# Objectif : Afficher les événements récents des services AD

Write-Host "=== 20 derniers événements du service NTDS ===" -ForegroundColor Cyan
Get-EventLog -LogName "Directory Service" -Newest 20 | Format-Table TimeGenerated, EntryType, Source, EventID, Message -AutoSize

Write-Host "`n=== Logs du service Netlogon ===" -ForegroundColor Yellow
Get-EventLog -LogName "System" -Newest 20 | Where-Object { $_.Source -eq "Netlogon" } | Format-Table TimeGenerated, EntryType, EventID, Message -AutoSize

Write-Host "`n=== Journaux modernes (Event Viewer v2) ===" -ForegroundColor Green
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
