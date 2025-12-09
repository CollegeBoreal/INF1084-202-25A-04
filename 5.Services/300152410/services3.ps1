# services3.ps1
# Objectif : Capturer les événements AD et les exporter vers un fichier CSV

$logPath = "C:\Logs\ADLogs.csv"

Write-Host "=== Export des 50 derniers événements AD vers $logPath ===" -ForegroundColor Cyan

# Créer le dossier Logs s’il n’existe pas
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory | Out-Null
}

# Exporter les événements
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
    Export-Csv -Path $logPath -NoTypeInformation

Write-Host "✅ Export terminé avec succès !"
