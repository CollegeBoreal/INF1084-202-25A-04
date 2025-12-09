# services3.ps1 - Ismail Trache 300150395
# Objectif : Exporter les evenements Directory Service dans un fichier CSV.

Write-Host "=== Export des journaux Directory Service vers C:\Logs\ADLogs.csv ===" -ForegroundColor Cyan

# Creer le dossier Logs s’il n’existe pas
if (!(Test-Path -Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
}

# Exporter les 50 derniers événements Directory Service
Get-WinEvent -LogName "Directory Service" -MaxEvents 50 |
Export-Csv -Path "C:\Logs\ADLogs.csv" -NoTypeInformation

Write-Host "`nExport termine avec succes !" -ForegroundColor Green
