# Services2.ps1 - Afficher les événements des services AD
# Auteur: 300151233

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  ÉVÉNEMENTS DES SERVICES ACTIVE DIRECTORY" -ForegroundColor Cyan
Write-Host "================================================
" -ForegroundColor Cyan

Write-Host "=== 20 derniers événements - Directory Service ===" -ForegroundColor Yellow

try {
    Get-EventLog -LogName "Directory Service" -Newest 20 | 
    Select-Object TimeGenerated, EntryType, Source, EventID | 
    Format-Table -AutoSize
} catch {
    Write-Host "Erreur: $_" -ForegroundColor Red
}

Write-Host "
=== Logs Netlogon ===" -ForegroundColor Yellow

try {
    Get-EventLog -LogName "System" -Newest 20 | 
    Where-Object {$_.Source -eq "Netlogon"} |
    Select-Object TimeGenerated, EntryType, EventID, Message |
    Format-Table -AutoSize
} catch {
    Write-Host "Aucun événement Netlogon" -ForegroundColor Red
}

Write-Host "
=== Événements WinEvent ===" -ForegroundColor Yellow

try {
    Get-WinEvent -LogName "Directory Service" -MaxEvents 20 | 
    Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
} catch {
    Write-Host "Erreur WinEvent: $_" -ForegroundColor Red
}
