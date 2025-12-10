# services2.ps1 - Ismail Trache 300150395
# Objectif : Afficher les evenements recents lies a Active Directory.

Write-Host "=== Derniers evenements Directory Service ===" -ForegroundColor Cyan

# 1. Afficher les 20 derniers evenements du service Directory Service
Get-EventLog -LogName "Directory Service" -Newest 20

Write-Host "`n=== Derniers evenements Netlogon (systeme) ===" -ForegroundColor Cyan

# 2. Afficher les 20 derniers logs systeme lies a Netlogon
Get-EventLog -LogName "System" -Newest 20 | Where-Object {$_.Source -eq "Netlogon"}

Write-Host "`n=== Journaux modernes (Event Viewer v2) ===" -ForegroundColor Cyan

# 3. Afficher les 20 derniers evenements Directory Service via le nouveau moteur de logs
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
