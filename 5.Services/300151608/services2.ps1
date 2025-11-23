# TP 5.Services - Étudiant : 300151608
# Script 2 — Consultation des journaux Active Directory

Write-Host "==== Événements Directory Service (NTDS) ====" -ForegroundColor Cyan

# 1️⃣ Afficher les 20 derniers événements NTDS
Get-EventLog -LogName "Directory Service" -Newest 20 |
Select-Object TimeGenerated, EntryType, Source, InstanceId, Message

Write-Host "`n==== Événements Netlogon du journal Système ====" -ForegroundColor Yellow

# 2️⃣ Logs du système filtrés sur Netlogon
Get-EventLog -LogName "System" -Newest 20 |
Where-Object { $_.Source -eq "Netlogon" } |
Select-Object TimeGenerated, EntryType, Source, Message

Write-Host "`n==== WinEvent (API moderne) - Directory Service ====" -ForegroundColor Green

# 3️⃣ Affichage via WinEvent
Get-WinEvent -LogName "Directory Service" -MaxEvents 20 |
Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

