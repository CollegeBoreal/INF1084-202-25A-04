# 300147786

$logPath = "C:\Logs\ADLogs.csv"

Write-Host "=== Export des 50 derniers événements AD vers $logPath ===" -ForegroundColor Cyan

#vérifier avant de créer 
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory | Out-Null
}

# capture des evenements
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path $logPath -NoTypeInformation

Write-Host "✅ Export terminé avec succès !"
